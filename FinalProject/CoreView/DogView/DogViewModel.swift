import Foundation

@MainActor
class DogViewModel: ObservableObject {
    
    @Published var fact: String = ""
    
    func getDogFact() async {
        do {
            fact = try await FactFetcher.shared.fetchDogFact()
        } catch CustomError.invalidURL {
            print("Invalid URL in dog fact")
        } catch CustomError.invalidResponse {
            print("Invalid response in dog fact")
        } catch CustomError.invalidData {
            print("Invalid data in dog fact")
        } catch {
            print("Unexpected error in dog fact.")
        }
    }
}
