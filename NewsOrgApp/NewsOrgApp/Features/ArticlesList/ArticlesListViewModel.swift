
// import UIKit // In MVVM UI design pattern, 'ViewModel' is 'View' agnostic

import Foundation
import Combine

final class ArticlesListViewModel : ObservableObject {
    @Published private(set) var state = State.idle
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
    deinit {
        bag.removeAll()
    }
    
    func send(event: Event) {
        input.send(event)
    }
}

// MARK: Inner Types

extension ArticlesListViewModel {
    enum State {
        case idle
        case loading
        case loaded([Article])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelect(Int)
        case onLoaded([Article])
        case onFailedToLoad(Error)
    }
    
    struct Article : Identifiable {
        var id: UUID
        let title: String
        let author: String
        let description: String
        let source: String
        let publishedAt: String
        let urlToImage: URL?
        let content: String
        
        init(article: ArticleDTO) {
            id = UUID()
            title = article.title ?? String()
            author = article.author ?? String()
            description = article.description ?? String()
            source = article.source.name ?? String()
            urlToImage = URL(string: article.urlToImage ?? "https://via.placeholder.com/300")
            
            let formatter = DateFormatter()
            
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = formatter.date(from: article.publishedAt) {
                formatter.dateFormat = "MMM dd YYYY, h:mm a"
                publishedAt = formatter.string(from: date)
            } else {
                publishedAt = formatter.string(from: Date())
            }
            
            content = article.content ?? String()
        }
    }
}

// MARK: - State Machine

extension ArticlesListViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onLoaded(let articles):
                return .loaded(articles)
            case .onFailedToLoad(let error):
                return .error(error)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else {
                return Empty().eraseToAnyPublisher()
            }
            
            return NewsAPI.headlines()
            .map {$0.articles.map(Article.init)}
            .map(Event.onLoaded)
            .catch { Just(Event.onFailedToLoad($0)) }
            .eraseToAnyPublisher()
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
