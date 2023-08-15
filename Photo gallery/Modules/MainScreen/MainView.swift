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
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.photos) { photo in
                    NavigationLink(destination: DetailView(imageURL: photo.imageURL, viewModel: detailsViewModel)) {
                        if let imageURL = photo.imageURL {
                            WebImage(url: imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .animation(.linear(duration: 0.4))
                        }
                    }
                }
            }
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
