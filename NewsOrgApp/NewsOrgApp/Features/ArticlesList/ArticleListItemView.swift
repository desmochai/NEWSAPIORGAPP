import SwiftUI
import Combine

struct ArticlesListItemView: View {
    let article: ArticlesListViewModel.Article
    
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        ZStack(alignment: .bottom) {
            card
            thumbnail
                .cornerRadius(30)
            overlay
                .cornerRadius(30)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    title
                    HStack {
                        source
                        timestamp
                    }
                }
            }
            .padding(.all, 16)
            .frame(width:300, height: 100)
            .foregroundColor(.offWhite)
        }
    }
    
    private var card: some View {
        RoundedRectangle(cornerRadius: 30)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
            .blendMode(.overlay)
            .frame(width: 300, height: 500)
    }
    
    private var overlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black, .black.opacity(0.01)]),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
        .frame(width: 300, height: 500)
    }
    
    private var thumbnail: some View {
        AsyncImage(
            url: article.urlToImage!,
            cache: cache,
            placeholder: spinner,
            configuration: { $0.resizable() }
        )
        .scaledToFill()
        .frame(
            width: 300,
            height: 500
        )
        .clipped()
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title2)
            .bold()
            .lineLimit(3)
    }
    
    private var source: some View {
        Text("Source: ".appending(article.source).uppercased())
            .font(.custom("stamp", size: 8))
    }
    
    private var timestamp: some View {
        Text(article.publishedAt.uppercased())
            .font(.custom("stamp", size: 8))
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}

// MARK: Seed preview canvas with data

struct ArticlesListItemView_Preview: PreviewProvider {
    static var previews: some View {
        
        let seed = ArticleDTO(
            title: "The Avengers",
            description: "Earth's Mightiest Heroes stand as the planet's first line of defense against the most powerful threats in the universe.",
            author: "Stan Lee",
            source: ArticleDTO.SourceDTO(id: "Marvel", name: "Marvel"),
            publishedAt: "2021-07-08T21:11:19+0000",
            urlToImage: "https://bit.ly/2TIuVqF",
            content: ""
        )
        ArticlesListItemView(
            article: ArticlesListViewModel.Article(
                article: seed
            )
        )
        .previewLayout(.device)
        .previewDevice("iPhone 11 Pro")
    }
}
