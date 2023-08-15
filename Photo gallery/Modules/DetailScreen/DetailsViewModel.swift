import Photos
import SwiftUI

final class DetailsViewModel: ObservableObject {
    var currentImageURL: URL?
    
    func saveImageToGallery() {
        guard let imageURL = currentImageURL else {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            if let imageData = try? Data(contentsOf: imageURL),
               let image = UIImage(data: imageData) {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
        }) { success, error in
            if success {
                print("Image saved to gallery successfully.")
            } else {
                if let error = error {
                    print("Error saving image to gallery: \(error.localizedDescription)")
                }
            }
        }
    }
}
