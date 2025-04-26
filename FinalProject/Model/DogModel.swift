import Foundation
import SwiftData

@Model
class DogModel: Codable {
    
    @Attribute(.unique)
    let id: Int
    
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    let referenceImageId: String
    let weight: Weight
    let height: Height
    let countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bredFor
        case breedGroup
        case lifeSpan
        case temperament
        case origin
        case referenceImageId
        case weight
        case height
        case countryCode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.bredFor = try? container.decode(String.self, forKey: .bredFor)
        self.breedGroup = try? container.decode(String.self, forKey: .breedGroup)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        self.temperament = try? container.decode(String.self, forKey: .temperament)
        self.origin = try? container.decode(String.self, forKey: .origin)
        self.referenceImageId = try container.decode(String.self, forKey: .referenceImageId)
        self.weight = try container.decode(Weight.self, forKey: .weight)
        self.height = try container.decode(Height.self, forKey: .height)
        self.countryCode = try? container.decode(String.self, forKey: .countryCode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.bredFor, forKey: .bredFor)
        try container.encode(self.breedGroup, forKey: .breedGroup)
        try container.encode(self.lifeSpan, forKey: .lifeSpan)
        try container.encode(self.temperament, forKey: .temperament)
        try container.encode(self.origin, forKey: .origin)
        try container.encode(self.referenceImageId, forKey: .referenceImageId)
        try container.encode(self.weight, forKey: .weight)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.countryCode, forKey: .countryCode)
    }
}

@Model
class Height: Codable {
    
    let imperial: String
    let metric: String
    
    enum CodingKeys: String, CodingKey {
        case imperial
        case metric
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imperial = try container.decode(String.self, forKey: .imperial)
        self.metric = try container.decode(String.self, forKey: .metric)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.imperial, forKey: .imperial)
        try container.encode(self.metric, forKey: .metric)
    }
}
