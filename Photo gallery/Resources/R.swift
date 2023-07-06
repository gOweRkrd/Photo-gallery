import SwiftUI

enum StringResources {
    
    enum MainView {
        static let title = "Photo Gallery"
        static let refreshText = "Refresh"
    }
    
    enum DetailView {
        static let errorText = "Image not available"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
    }
}

typealias R = StringResources
