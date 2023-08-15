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
}
