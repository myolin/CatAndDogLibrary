import Foundation
import SwiftData

extension CatModel {

    // sample cats data for preview
    static var sampleCats: [CatModel] {
        get {
            guard let url = Bundle.main.url(forResource: "SampleCatData", withExtension: "json") else {
                fatalError("Failed to find SampleCatData.json")
            }
            
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
               return try decoder.decode([CatModel].self, from: data)
            } catch {
                fatalError("Failed to decode sample cat data")
            }
        }
    }
}

extension DogModel {

    // sample dogs data for preview
    static var sampleDogs: [DogModel] {
        get {
            guard let url = Bundle.main.url(forResource: "SampleDogData", withExtension: "json") else {
                fatalError("Failed to find SampleDogData.json")
            }
            
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
               return try decoder.decode([DogModel].self, from: data)
            } catch {
                fatalError("Failed to decode sample dog data")
            }
        }
    }
}

