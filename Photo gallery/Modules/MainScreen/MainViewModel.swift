import SDWebImageSwiftUI
import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var photos: [PhotoModel] = []
    @Published var isLoading: Bool = false

    func fetchPhotos() {
        let key = "dc1bcc94279ed5b3be81b9f5b7188d01565f5e9eefad81f9fb9b805daf5dec30"
        let urlString = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        
        guard let url = URL(string: urlString) else {
            return
        }

        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let searchResult = try JSONDecoder().decode([PhotoModel].self, from: data)
                DispatchQueue.main.async {
                    self.photos = searchResult
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}
