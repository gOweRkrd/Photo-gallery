import Combine
import SDWebImageSwiftUI
import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var photos: [PhotoModel] = []
    @Published var isLoading: Bool = false
    
    private let networkManager = NetworkManager()
    private var cancellables: Set<AnyCancellable> = []
    
    private var currentPage: Int = 1
    
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
    
    func fetchMorePhotos() {
        isLoading = true
        
        networkManager.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching more photos: \(error.localizedDescription)")
                    }
                    self?.isLoading = false
                },
                receiveValue: { [weak self] newPhotos in
                    self?.photos.append(contentsOf: newPhotos)
                    self?.isLoading = false
                    self?.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }
    
    func paginationPhotos() {
        if let lastPhoto = photos.last,
           let lastIndex = photos.firstIndex(where: { $0.id == lastPhoto.id }),
           lastIndex == photos.count - 1 {
            fetchMorePhotos()
        }
    }
}
