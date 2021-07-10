import Combine
import SwiftUI

struct ArticlesListView: View {
    @ObservedObject var viewModel: ArticlesListViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Top Headlines")
        }
        .onAppear { self.viewModel.send(event: .onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(
                isAnimating: true,
                style: .medium
            ).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let articles):
            return list(of: articles).eraseToAnyView()
        }
    }
    
    private func list(of articles: [ArticlesListViewModel.Article]) -> some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            LazyVStack(alignment:.leading, spacing: 8, content: {
                ForEach(articles) { article in
                    NavigationLink(
                        destination: ArticleDetailView(article: article),
                        label: { ArticlesListItemView(article: article) }
                    )
                }
            })
            .padding(.horizontal, 8)
            .animation(.easeIn)
        })
    }
}

struct ArticlesListView_Preview: PreviewProvider {
    static var previews: some View {
        ArticlesListView(viewModel: ArticlesListViewModel())
            .preferredColorScheme(.light)
            .previewLayout(.device)
            .previewDevice("iPhone 11 Pro")
    }
}


