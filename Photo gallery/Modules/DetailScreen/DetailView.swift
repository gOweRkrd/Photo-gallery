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
            VStack {
                if imageURL != nil {
                    imageLoader
                } else {
                    errorText
                }
                Spacer()
                saveButtonImageGallery
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
        .padding(.bottom, 20)
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
        Text(R.DetailView.buttonDescription)
            .customFont(SFProDisplay.bold, category: .extraExtraLarge)
            .foregroundColor(Color(R.Colors.black))
            .padding()
            .background(Color(R.Colors.lightBlue))
            .cornerRadius(10)
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
