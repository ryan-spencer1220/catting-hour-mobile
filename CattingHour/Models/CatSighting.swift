import Foundation
import CoreLocation

struct CatSighting: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String?
    var type: String
    var notes: String
    var dateSeen: Date
    var latitude: Double
    var longitude: Double
    var imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, name, type, notes
        case dateSeen = "date_seen"
        case latitude, longitude
        case imageUrl = "image_url"
    }
}
