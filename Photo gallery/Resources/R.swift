import SwiftUI

enum StringResources {
    
    enum MainView {
        static let title = "Photo Gallery"
    }
    
    enum DetailView {
        static let errorText = "Image not available"
        static let buttonDescription = "Save to Gallery"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
        static let lightBlue = UIColor(hexString: "#74CFFB")
    }
}

typealias R = StringResources
