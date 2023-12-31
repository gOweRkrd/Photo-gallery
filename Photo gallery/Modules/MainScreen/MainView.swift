import SDWebImageSwiftUI
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    @ObservedObject var detailsViewModel = DetailsViewModel()
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    if viewModel.isLoading {
                        progressView
                    } else if !viewModel.photos.isEmpty {
                        mainContent
                    } else {
                        errorImage
                    }
                }
                .navigationTitle(R.MainView.title)
            }
            .onAppear { viewModel.fetchPhotos() }
        }
        .refreshable { viewModel.fetchPhotos() }
    }
}

// MARK: - Ui

private extension MainView {
    
    var progressView: some View {
        ProgressView().scaleEffect(2.0)
    }
    
    var mainContent: some View {
        ScrollViewReader { _ in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.photos, id: \.id) { photo in
                        NavigationLink(
                            destination: DetailView(
                                imageURL: photo.imageURL,
                                viewModel: detailsViewModel
                            )
                        ) {
                            if let imageURL = photo.imageURL {
                                WebImage(url: imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .animation(.linear(duration: 0.1))
                            }
                        }
                        .id(photo.id)
                    }
                    .onAppear { viewModel.paginationPhotos() }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    var errorImage: some View {
        Image("error404").clipShape(Capsule())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
