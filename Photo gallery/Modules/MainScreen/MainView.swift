import SDWebImageSwiftUI
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            Color(R.Colors.white).edgesIgnoringSafeArea(.all)
            NavigationView {
                Group {
                    if viewModel.isLoading {
                        Text("Loading...")
                    } else if !viewModel.photos.isEmpty {
                        List(viewModel.photos) { photo in
                            NavigationLink(destination: DetailView(imageURL: photo.imageURL)) {
                                VStack {
                                    if let imageURL = photo.imageURL {
                                        WebImage(url: imageURL)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        }
                        .listStyle(.grouped)
                    } else {
                        Text("No photos available")
                    }
                }
                .navigationTitle("Photo Gallery")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Refresh") {
                            viewModel.fetchPhotos()
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchPhotos()
            }
        }
    }
}
