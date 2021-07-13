import SwiftUI

struct ArticleDetailView: View {
    let article: ArticlesListViewModel.Article
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    title
                    VStack(alignment: .center) {
                        thumbnail
                    }
                    HStack { author; timestamp }
                    content
                }
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
            )
            .padding([.horizontal])
            .navigationBarTitle(article.source)
        })
    }
    
    private var title: some View {
        Text(article.title)
            .font(.title)
            .bold()
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
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 300,
              maxHeight: 300,
              alignment: .center
        )
        .clipped()
        .cornerRadius(10.0)
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
    
    private var author: some View {
        Text("Author: ".appending(article.author).uppercased())
            .foregroundColor(.accentColor)
            .font(.custom("stamp", size: 8))
    }
    
    private var content: some View {
        Text(article.content)
            .font(.body)
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
