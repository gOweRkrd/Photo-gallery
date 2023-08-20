import Combine
import Foundation

final class NetworkManager {
    
    private let apiKey = "7OMq0nV9945bOhdTvJTG_Y4UYZkx2sur1cyemnegL6c"
    private let baseURL = "https://api.unsplash.com/photos/random"
    
    func fetchPhotos() -> AnyPublisher<[PhotoModel], Error> {
        guard let url = URL(string: "\(baseURL)?count=30&client_id=\(apiKey)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.httpError(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case unknownError(Error)
}
