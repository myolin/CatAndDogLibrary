import Foundation

@MainActor
class CatViewModel: ObservableObject {
    
    @Published var fact: String = ""
    
    func getCatFact() async {
        do {
            fact = try await FactFetcher.shared.fetchCatFact()
        } catch CustomError.invalidURL {
            print("Invalid URL in cat fact")
        } catch CustomError.invalidResponse {
            print("Invalid response in cat fact")
        } catch CustomError.invalidData {
            print("Invalid data in cat fact")
        } catch {
            print("Unexpected error in cat fact.")
        }
    }
}
