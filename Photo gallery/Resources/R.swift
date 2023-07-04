import SwiftUI

enum StringResources {
    
    enum MainView {
        static let title = "Photo gallery"
        static let description = "Find any photos to your taste"
        static let next = "Next"
        static let page = "Page"
    }
    
    enum NetworkManager {
        static let invalidUrl = "Invalid URL"
        static let invalidResponse = "Invalid response"
        static let statusCode = "Unexpected status code:"
    }
    
    enum MainViewModel {
        static let networkError = "network Error"
        static let decodingError = "decoding Error"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
        static let gray = UIColor(hexString: "#A9A9A9")
        static let lightGray = UIColor(hexString: "#F8F8F8")
        static let lightBlue = UIColor(hexString: "#00AEFF")
    }
}

typealias R = StringResources
