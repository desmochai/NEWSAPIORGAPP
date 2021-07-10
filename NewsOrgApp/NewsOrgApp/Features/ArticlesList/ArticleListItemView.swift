import SwiftUI
import Combine

struct ArticlesListItemView: View {
    let article: ArticlesListViewModel.Article
    
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            thumbnail
            VStack(alignment: .leading, spacing: 8, content: {
                title
                HStack(alignment: .center, spacing: nil, content: {
                    source
                    timestamp
                })
                description
            })
        })
    }
    
    private var thumbnail: some View {
        AsyncImage(
            url: article.urlToImage!,
            cache: cache,
            placeholder: spinner,
            configuration: { $0.resizable() }
        )
        .scaledToFill()
        .frame(width: 100, height: 100)
        .cornerRadius(8.0)
        .padding(.vertical, 4)
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
            .bold()
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
    
    private var source: some View {
        Text("Source: ".appending(article.source).uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 10))
    }
    
    private var timestamp: some View {
        Text(article.publishedAt.uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 10))
    }
    
    private var description: some View {
        Text(article.description)
            .fontWeight(.light)
            .font(.footnote)
            .lineLimit(3)
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
        .preferredColorScheme(.light)
        .previewLayout(.device)
        .previewDevice("iPhone 11 Pro")
    }
}
