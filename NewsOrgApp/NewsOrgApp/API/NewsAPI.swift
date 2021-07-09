import Foundation
import Combine

enum NewsAPI {
    private static let baseURL = URL(string: Constants.BASE_URL)!
    private static let apiKey = Constants.NEWS_API_KEY
    private static let country = "us"
    private static let category = "politics"
    private static let agent = Agent()
    
    static func headlines() -> AnyPublisher<RootDTO, Error> {
        let request = URLComponents(
            url: baseURL.appendingPathComponent("top-headlines"),
            resolvingAgainstBaseURL: true)?
            .queryItems(apiKey, country, category)
            .request
        
        debugPrint(request.debugDescription)
        
        return agent.run(request!)
    }
}

// MARK: Data Transfer Objects

struct RootDTO: Codable {
    let articles: [ArticleDTO]
}

struct ArticleDTO: Codable {
    let title: String?
    let description: String?
    let author: String?
    let source: SourceDTO
    let publishedAt: String
    let urlToImage: String?
    let content: String?
    
    struct SourceDTO: Codable {
        let id: String?
        let name: String?
    }
}

// MARK: An extension to add query items

private extension URLComponents {
    func queryItems(_ apiKey: String, _ country: String, _ category: String) -> URLComponents {
        var copy = self
        copy.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return copy
    }
    
    var request: URLRequest? {
        url.map {
            URLRequest.init(url: $0)
        }
    }
}
