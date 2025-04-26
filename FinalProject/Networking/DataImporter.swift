import Foundation

struct DataImporter {
    
    private let apiKey = "live_2p2KsL01uN0xBUzW7djYrc4tQMu3hLSWUZorWxvlNBosasZ4MpPOvHkdZhTL7JHF"
    
    // cats
    private let catEndpoint = "https://api.thecatapi.com/v1/breeds"
    private let catCoverPhotoEndpoint = "https://api.thecatapi.com/v1/images/"
    let catImageEndpoint = "https://api.thecatapi.com/v1/images/search?limit=10&breed_ids="
    
    // dogs
    private let dogEndpoint = "https://api.thedogapi.com/v1/breeds"
    private let dogCoverPhotoEndpoint = "https://api.thedogapi.com/v1/images/"
    let dogImageEndpoint = "https://api.thedogapi.com/v1/images/search?limit=10&breed_ids="
    
    static let shared = DataImporter()
    
    private init() { }
    
    // fetch all cat breeds
    func loadCats() async throws -> [CatModel] {
        guard let url = URL(string: catEndpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([CatModel].self, from: data)
        } catch {
            throw CustomError.invalidData
        }
    }
    
    // fetch all dog breeds
    func loadDogs() async throws -> [DogModel] {
        guard let url = URL(string: dogEndpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([DogModel].self, from: data)
        } catch {
            throw CustomError.invalidData
        }
    }
    
    // Fetch 10 photos of a specific breed
    func fetchPhotos(id: String, endpoint: String) async throws -> [String]{
        guard let url = URL(string: "\(endpoint)\(id)&api_key=\(apiKey)") else {
            throw CustomError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode([ImageModel].self, from: data)
            var imagesUrl: [String] = []
            for data in decodedData {
                imagesUrl.append(data.url)
            }
            return imagesUrl
        } catch {
            throw CustomError.invalidData
        }
    }
    
}
