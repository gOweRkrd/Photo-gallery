import Combine
import SDWebImageSwiftUI
import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var photos: [PhotoModel] = []
    @Published var isLoading: Bool = false
    
    private let networkManager = NetworkManager()
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPhotos() {
        isLoading = true
        
        networkManager.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                            print("Error fetching photos: \(error.localizedDescription)")
                            self?.photos = []
                    case .finished:
                            break
                    }
                    self?.isLoading = false
                },
                receiveValue: { [weak self] photos in
                    self?.photos = photos
                }
            )
            .store(in: &cancellables)
    }
}
