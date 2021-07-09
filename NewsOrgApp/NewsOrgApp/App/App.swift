import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup { ArticlesListView(viewModel: ArticlesListViewModel()) }
    }
}
