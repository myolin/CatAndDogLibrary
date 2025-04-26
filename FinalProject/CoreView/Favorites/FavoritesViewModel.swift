import Foundation
import SwiftUI
import SwiftData

class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteCats: [CatModel] = []
    @Published var favoriteDogs: [DogModel] = []
    
    var modelContext: ModelContext? = nil
    private let service = FirestoreService()
    var catsID: [String] = []
    var dogsID: [Int] = []
    
    func fetchAllFavoriteFromFirestore() {
        Task {
            catsID = await service.getFavoriteCats()
            dogsID = await service.getFavoriteDogs()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchFavoriteCats()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchFavoriteDogs()
        }
    }
    
    // Get favorite cat from swiftdata with cat id fetched from firestore
    func fetchFavoriteCats() {
        catsID.forEach { id in
            let descriptor = FetchDescriptor<CatModel>(predicate: #Predicate {
                $0.id == id
            })
            let cat = (try? (modelContext?.fetch(descriptor) ?? [])) ?? []
            cat.forEach { cat in
                DispatchQueue.main.async {
                    self.favoriteCats.append(cat)
                }
            }
        }
    }
    
    // Get favorite dog from swiftdata with dog id fetched from firestore
    func fetchFavoriteDogs() {
        dogsID.forEach { id in
            let descriptor = FetchDescriptor<DogModel>(predicate: #Predicate {
                $0.id == id
            })
            let dog = (try? (modelContext?.fetch(descriptor) ?? [])) ?? []
            dog.forEach { dog in
                DispatchQueue.main.async {
                    self.favoriteDogs.append(dog)
                }
            }
        }
    }
    
    
    
    
    
    
}
