import SwiftUI

enum StringResources {
    
    enum MainView {
        static let title = "Photo Gallery"
    }
    
    enum DetailView {
        static let errorText = "Image not available"
        static let buttonDescription = "Save to Gallery"
        static let titleAlert = "IMAGE SAVED"
        static let messageAlert = "The image has been successfully saved to your gallery."
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
        static let lightBlue = UIColor(hexString: "#74CFFB")
    }
}

typealias R = StringResources
