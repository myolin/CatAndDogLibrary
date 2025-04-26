import Foundation

class FactFetcher {
    
    static let shared = FactFetcher()
    
    let dogFactEndpoint = "http://dog-api.kinduff.com/api/facts"
    let catFactEndpoint = "https://meowfacts.herokuapp.com/"
    
    private init() { }
    
    func fetchDogFact() async throws -> String {
        guard let url = URL(string: dogFactEndpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(DogFact.self, from: data)
            if let fact = decodedData.facts {
                return fact[0]
            }
            
        } catch {
            throw CustomError.invalidData
        }
        return "Try Again!"
    }
    
    func fetchCatFact() async throws -> String {
        guard let url = URL(string: catFactEndpoint) else {
            throw CustomError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CatFact.self, from: data)
            if let fact = decodedData.data {
                return fact[0]
            }
        } catch {
            throw CustomError.invalidData
        }
        return "Try Again!"
    }
}
