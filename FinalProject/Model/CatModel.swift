import Foundation
import SwiftData

@Model
class CatModel: Codable {
    
    @Attribute(.unique)
    let id: String
    
    let name: String
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let desc: String
    let lifeSpan: String
    let indoor: Int
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let hypoallergenic: Int
    let wikipediaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    let referenceImageId: String?
    let lap: Int?
    let weight: Weight
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case origin
        case countryCodes
        case countryCode
        case desc = "description"
        case lifeSpan
        case indoor
        case adaptability
        case affectionLevel
        case childFriendly
        case dogFriendly
        case energyLevel
        case grooming
        case healthIssues
        case intelligence
        case sheddingLevel
        case socialNeeds
        case strangerFriendly
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressedTail
        case shortLegs
        case hypoallergenic
        case wikipediaUrl
        case vetstreetUrl
        case vcahospitalsUrl
        case referenceImageId
        case lap
        case weight
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.temperament = try container.decode(String.self, forKey: .temperament)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.countryCodes = try container.decode(String.self, forKey: .countryCodes)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        self.indoor = try container.decode(Int.self, forKey: .indoor)
        self.adaptability = try container.decode(Int.self, forKey: .adaptability)
        self.affectionLevel = try container.decode(Int.self, forKey: .affectionLevel)
        self.childFriendly = try container.decode(Int.self, forKey: .childFriendly)
        self.dogFriendly = try container.decode(Int.self, forKey: .dogFriendly)
        self.energyLevel = try container.decode(Int.self, forKey: .energyLevel)
        self.grooming = try container.decode(Int.self, forKey: .grooming)
        self.healthIssues = try container.decode(Int.self, forKey: .healthIssues)
        self.intelligence = try container.decode(Int.self, forKey: .intelligence)
        self.sheddingLevel = try container.decode(Int.self, forKey: .sheddingLevel)
        self.socialNeeds = try container.decode(Int.self, forKey: .socialNeeds)
        self.strangerFriendly = try container.decode(Int.self, forKey: .strangerFriendly)
        self.vocalisation = try container.decode(Int.self, forKey: .vocalisation)
        self.experimental = try container.decode(Int.self, forKey: .experimental)
        self.hairless = try container.decode(Int.self, forKey: .hairless)
        self.natural = try container.decode(Int.self, forKey: .natural)
        self.rare = try container.decode(Int.self, forKey: .rare)
        self.rex = try container.decode(Int.self, forKey: .rex)
        self.suppressedTail = try container.decode(Int.self, forKey: .suppressedTail)
        self.shortLegs = try container.decode(Int.self, forKey: .shortLegs)
        self.hypoallergenic = try container.decode(Int.self, forKey: .hypoallergenic)
        self.wikipediaUrl = try? container.decode(String.self, forKey: .wikipediaUrl)
        self.vetstreetUrl = try? container.decode(String.self, forKey: .vetstreetUrl)
        self.vcahospitalsUrl = try? container.decode(String.self, forKey: .vcahospitalsUrl)
        self.referenceImageId = try? container.decode(String?.self, forKey: .referenceImageId)
        self.lap = try? container.decode(Int?.self, forKey: .lap)
        self.weight = try container.decode(Weight.self, forKey: .weight)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.temperament, forKey: .temperament)
        try container.encode(self.origin, forKey: .origin)
        try container.encode(self.countryCodes, forKey: .countryCodes)
        try container.encode(self.countryCode, forKey: .countryCode)
        try container.encode(self.desc, forKey: .desc)
        try container.encode(self.lifeSpan, forKey: .lifeSpan)
        try container.encode(self.indoor, forKey: .indoor)
        try container.encode(self.adaptability, forKey: .adaptability)
        try container.encode(self.affectionLevel, forKey: .affectionLevel)
        try container.encode(self.childFriendly, forKey: .childFriendly)
        try container.encode(self.dogFriendly, forKey: .dogFriendly)
        try container.encode(self.energyLevel, forKey: .energyLevel)
        try container.encode(self.grooming, forKey: .grooming)
        try container.encode(self.healthIssues, forKey: .healthIssues)
        try container.encode(self.intelligence, forKey: .intelligence)
        try container.encode(self.sheddingLevel, forKey: .sheddingLevel)
        try container.encode(self.socialNeeds, forKey: .socialNeeds)
        try container.encode(self.strangerFriendly, forKey: .strangerFriendly)
        try container.encode(self.vocalisation, forKey: .vocalisation)
        try container.encode(self.experimental, forKey: .experimental)
        try container.encode(self.hairless, forKey: .hairless)
        try container.encode(self.natural, forKey: .natural)
        try container.encode(self.rare, forKey: .rare)
        try container.encode(self.rex, forKey: .rex)
        try container.encode(self.suppressedTail, forKey: .suppressedTail)
        try container.encode(self.shortLegs, forKey: .shortLegs)
        try container.encode(self.hypoallergenic, forKey: .hypoallergenic)
        try container.encode(self.wikipediaUrl, forKey: .wikipediaUrl)
        try container.encode(self.vetstreetUrl, forKey: .vetstreetUrl)
        try container.encode(self.vcahospitalsUrl, forKey: .vcahospitalsUrl)
        try container.encode(self.referenceImageId, forKey: .referenceImageId)
        try container.encode(self.lap, forKey: .lap)
        try container.encode(self.weight, forKey: .weight)
    }
}

@Model
class Weight: Codable {
    
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
