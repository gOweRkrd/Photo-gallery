import SDWebImageSwiftUI
import SwiftUI

struct PhotoModel: Identifiable, Decodable, Hashable {
    
    var id: String
    var urls: [String: String]
    var imageURL: URL?

    init(id: String, urls: [String: String]) {
        self.id = id
        self.urls = urls
        self.imageURL = URL(string: urls["regular"] ?? "")
    }
    
    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.id == rhs.id && lhs.urls == rhs.urls
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        urls = try container.decode([String: String].self, forKey: .urls)
        imageURL = URL(string: urls["regular"] ?? "")
    }
}
