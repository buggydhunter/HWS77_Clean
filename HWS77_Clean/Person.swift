import Foundation
import SwiftUI

struct Person: Identifiable, Comparable, Codable, Equatable, Hashable {
    var id: UUID
    var name: String
    var images: [UIImage]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case images
    }
    
    // 1. Restore the standard initializer
    init(id: UUID = UUID(), name: String, images: [UIImage]) {
        self.id = id
        self.name = name
        self.images = images
    }
    
    // 2. Decode from JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        // Decode the JSON data as an array of Data ([Data])
        let imagesData = try container.decode([Data].self, forKey: .images)
        
        // Convert [Data] back into [UIImage]
        images = imagesData.compactMap { UIImage(data: $0) }
    }

    // 3. Encode to JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        // Convert [UIImage] into [Data]
        let imagesData = images.compactMap { $0.jpegData(compressionQuality: 0.8) }
        
        // Encode the resulting data array
        try container.encode(imagesData, forKey: .images)
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
       return lhs.id == rhs.id
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
