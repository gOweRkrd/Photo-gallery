import SDWebImageSwiftUI
import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { refreshButton }
                }
            }
            .onAppear { viewModel.fetchPhotos() }
        }
    }
}

// MARK: - Ui

private extension MainView {
    
    var progressView: some View {
        ProgressView().scaleEffect(2.0)
    }
    
    var mainContent: some View {
        List(viewModel.photos) { photo in
            NavigationLink(destination: DetailView(imageURL: photo.imageURL)) {
                VStack {
                    if let imageURL = photo.imageURL {
                        WebImage(url: imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .animation(.linear(duration: 0.4))
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
        .listStyle(.grouped)
    }
    
    var errorImage: some View {
        Image("error404").clipShape(Capsule())
    }
    
    var refreshButton: some View {
        Button(
            action: { viewModel.fetchPhotos() },
            label: { refreshText }
        )
    }
    
    var refreshText: some View {
        Text(R.MainView.refreshText)
            .customFont(SFProDisplay.bold, category: .extraLarge)
            .foregroundColor(Color(R.Colors.black))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
