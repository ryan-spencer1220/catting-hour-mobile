import Foundation
import CoreLocation

struct CatSighting: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String?
    var notes: String
    var dateSeen: Date
    var latitude: Double
    var longitude: Double
    var imageUrl: String?
}
