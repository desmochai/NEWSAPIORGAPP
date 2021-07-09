import SwiftUI

struct ArticleDetailView: View {
    let article: ArticlesListViewModel.Article
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8, content: {
                title
                HStack(alignment: .center, spacing: nil, content: {
                    source
                    timestamp
                })
                    Divider()
                thumbnail
                    Divider()
                author
                content
            })
        }
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
            .bold()
            .multilineTextAlignment(.center)
    }
    
    private var source: some View {
        Text("Source: ".appending(article.source).uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 8))
    }
    
    private var timestamp: some View {
        Text(article.publishedAt.uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 8))
    }
    
    private var thumbnail: some View {
        AsyncImage(
            url: article.urlToImage!,
            cache: cache,
            placeholder: spinner,
            configuration: { $0.resizable() }
        )
        .scaledToFill()
        .frame(width: 300, height: 300)
        .cornerRadius(8.0)
    }
    
    private var author: some View {
        Text("Author: ".appending(article.author).uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 8))
    }
    
    private var content: some View {
        Text(article.content)
            .font(.body)
            .padding([.leading, .trailing], 16)
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let seed = ArticleDTO(
            title: "The Avengers",
            description: "Earth's Mightiest Heroes stand as the planet's first line of defense against the most powerful threats in the universe.",
            author: "Stan Lee",
            source: ArticleDTO.SourceDTO(id: "Marvel", name: "Marvel"),
            publishedAt: "2021-07-08T21:11:19+0000",
            urlToImage: "https://bit.ly/2TIuVqF",
            content: "The Avengers Initiative was the brainchild of S.H.I.E.L.D. Director Nick Fury. He first approached Tony Stark with the idea, following Tony’s defeat of Obadiah Stane and his subsequent public announcement that he was Iron Man. Fury kept his eye on several potential members, as Bruce Banner struggled with life as the Hulk, the Asgardian Thor appeared on Earth, and Steve Rogers, AKA World War II hero Captain America, was discovered alive decades after his apparent death. In the meantime, some of S.H.I.E.L.D.’s most skilled members, Black Widow (Natasha Romanoff), and Hawkeye (Clint Barton), were making a name for themselves and impressing Fury."
        )
        
        ArticleDetailView(
            article: ArticlesListViewModel.Article(article: seed)
        )
    }
}

/*
    Until Apple designs testability into SwiftUI, we're screwed :/ 
*/
