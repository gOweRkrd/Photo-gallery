import Photos
import SDWebImageSwiftUI
import SwiftUI

struct DetailView: View {
    
    var imageURL: URL?
    @State private var scale: CGFloat = 1.0
    @State private var showAlert = false

    @ObservedObject var viewModel: DetailsViewModel
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).edgesIgnoringSafeArea(.all)
            
            if imageURL != nil {
                imageLoader
            } else {
                errorText
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
//                    favoritesButton
                }
                HStack {
                    Spacer()
                    saveButtonImageGallery
                }
            }
        }
        .navigationBarItems(trailing: shareButton)
    }
}

// MARK: - Ui

private extension DetailView {
    
    var imageLoader: some View {
        WebImage(url: imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(scale)
            .gesture(
                TapGesture(count: 2)
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            scale = scale == 1.0 ? 2.0 : 1.0
                        }
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = value.magnitude
                    }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.bottom)
    }
    
    var errorText: some View {
        Text(R.DetailView.errorText)
            .customFont(SFProDisplay.medium, category: .extraLarge)
            .foregroundColor(Color(R.Colors.black))
    }
    
    var saveButtonImageGallery: some View {
        Button(
            action: { actionSaveImageGallery() },
            label: { buttonDescription }
        )
        .alert(isPresented: $viewModel.isImageSaved) {
            Alert(
                title: Text(R.DetailView.titleAlert),
                message: Text(R.DetailView.messageAlert),
                dismissButton: .default(Text("OK")) {
                    viewModel.isImageSaved = false
                }
            )
        }
    }
    
    func actionSaveImageGallery() {
        viewModel.currentImageURL = imageURL
        viewModel.saveImageToGallery()
    }
    
    var buttonDescription: some View {
        Image(systemName: "square.and.arrow.down.fill")
            .foregroundColor(Color(R.Colors.black))
            .frame(width: 50, height: 50)
            .background(Color(R.Colors.lightGray))
            .clipShape(Circle())
            .padding([.bottom, .trailing], 20)
    }
    
    var favoritesButton: some View {
        Button(
            action: {},
            label: { favoritesButtonDescription }
        )
    }
    
    var favoritesButtonDescription: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(Color(R.Colors.black))
            .frame(width: 50, height: 50)
            .background(Color(R.Colors.lightGray))
            .clipShape(Circle())
            .padding([.bottom, .trailing], 20)
    }
    
    var shareButton: some View {
        Button(
            action: { actionShareButton() },
            label: { Image(systemName: "square.and.arrow.up").foregroundColor(Color(R.Colors.black)) }
        )
    }
    
    func actionShareButton() {
        guard let imageURL = imageURL else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [imageURL],
            applicationActivities: nil
        )
        UIApplication.shared.windows.first?.rootViewController?.present(
            activityViewController,
            animated: true,
            completion: nil
        )
    }
}
