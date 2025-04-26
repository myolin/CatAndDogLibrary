import Foundation

struct Predictions: Codable {
    let predictions: [Prediction]
}

struct Prediction: Codable {
    let breed: String
    let confidence: Double
    
    enum CodingKeys: String, CodingKey {
        case breed = "class"
        case confidence
    }
    
}
