import SDWebImageSwiftUI
import SwiftUI

struct DetailView: View {
    
    var imageURL: URL?
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).edgesIgnoringSafeArea(.all)
            
            if imageURL != nil {
                imageLoader
            } else {
                errorText
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
}
