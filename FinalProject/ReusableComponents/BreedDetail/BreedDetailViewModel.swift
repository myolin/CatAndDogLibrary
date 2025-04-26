import Foundation

@MainActor
class BreedDetailViewModel: ObservableObject {
    @Published var photoUrl: [String] = []
    @Published var isCatFav: Bool = false
    @Published var isDogFav: Bool = false
    
    private let service = FirestoreService()
    
    // Get breed photos urls only
    func getPhotoUrl(id: String, endpoint: String) async {
        do {
            let fetched = try await DataImporter.shared.fetchPhotos(id: id, endpoint: endpoint)
            DispatchQueue.main.async {
                self.photoUrl = fetched
            }
        } catch CustomError.invalidURL {
            print("Invalid URL")
        } catch CustomError.invalidResponse {
            print("Invalid Response")
        } catch CustomError.invalidData {
            print("Invalid Data")
        } catch {
            print("Unexpected Error")
        }
    }
    
    // call firebase service to add to favorite
    func addCatToFavorite(id: String, name: String) {
        service.addFavoriteCat(id: id, name: name)
    }
    
    // call firebase service to add to favorite
    func addDogToFavorite(id: String, name: String) {
        service.addFavoriteDog(id: id, name: name)
    }
    
    // remove favorite cat
    func removeCatFromFavorite(id: String) async {
        await service.removeFavoriteCat(id: id)
    }
    
    // remove favorite dog
    func removeDogFromFavorite(id: String) async {
        await service.removeFavoriteDog(id: id)
    }
    
    // check if cat is already favorite or not
    func checkIfCatIsFav(id: String) async {
        isCatFav = await service.checkIfCatIsFavorite(id: id)
    }
    
    // check if cat is already favorite or not
    func checkIfDogIsFav(id: String) async {
        isDogFav = await service.checkIfDogIsFavorite(id: id)
    }
}
