import SDWebImageSwiftUI
import SwiftUI

struct DetailView: View {
    @State private var scale: CGFloat = 1.0
    
    var imageURL: URL?
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).edgesIgnoringSafeArea(.all)

            if let imageURL = imageURL {
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
            } else {
                Text("Image not available")
            }
        }
    }
}
