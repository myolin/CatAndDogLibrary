import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirestoreService {
    
    private let db = Firestore.firestore()
    private let userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    // add favorite cat to firestore
    func addFavoriteCat(id: String, name: String) {
        if let userSession = userSession {
            let favCatCollection = db.collection("users").document(userSession.uid).collection("FavoriteCats")
            favCatCollection.document(id).setData(["name":"\(name)"])
        }
    }
    
    // add favorite dog to firestore
    func addFavoriteDog(id: String, name: String) {
        if let userSession = userSession {
            let favDogCollection = db.collection("users").document(userSession.uid).collection("FavoriteDogs")
            favDogCollection.document(id).setData(["name":"\(name)"])}
    }
    
    // fetch all favorite cats from firestore
    func getFavoriteCats() async -> [String]{
        if let userSession = userSession {
            do {
                let querySnapshot = try await self.db.collection("users").document(userSession.uid).collection("FavoriteCats").getDocuments()
                var catsID: [String] = []
                for document in querySnapshot.documents {
                    catsID.append(document.documentID)
                }
                return catsID
            } catch {
                print("Error getting favorite cats from firestore")
            }
        }
        return []
    }
    
    // fetch all favorite dogs from firestore
    func getFavoriteDogs() async -> [Int] {
        if let userSession = userSession {
            do {
                let querySnapshot = try await self.db.collection("users").document(userSession.uid).collection("FavoriteDogs").getDocuments()
                var dogsID: [Int] = []
                for document in querySnapshot.documents {
                    dogsID.append(Int(document.documentID) ?? 0)
                }
                return dogsID
            } catch {
                print("Error getting favorite dogs from firestore")
            }
        }
        return []
    }
    
    // check if cat from paramater is already favorite
    func checkIfCatIsFavorite(id: String) async -> Bool{
        if let userSession = userSession {
            do {
                let querySnapshot = try await self.db.collection("users").document(userSession.uid).collection("FavoriteCats").getDocuments()
                for document in querySnapshot.documents {
                    if document.documentID == id {
                        return true
                    }
                }
            } catch {
                print("Error checking if the cat is already favorite")
            }
        }
        return false
    }
    
    // check if dog from parameter is already favorite
    func checkIfDogIsFavorite(id: String) async -> Bool{
        if let userSession = userSession {
            do {
                let querySnapshot = try await self.db.collection("users").document(userSession.uid).collection("FavoriteDogs").getDocuments()
                for document in querySnapshot.documents {
                    if document.documentID == id {
                        return true
                    }
                }
            } catch {
                print("Error checking if the dog is already favorite")
            }
        }
        return false
    }
    
    // remove cat from firestore favorite list
    func removeFavoriteCat(id: String) async {
        if let userSession = userSession {
            do {
                try await db.collection("users").document(userSession.uid).collection("FavoriteCats").document(id).delete()
            } catch {
                print("Error printing favorite cat from firestore")
            }
        }
    }
    
    // remove dog from firestore favorite list
    func removeFavoriteDog(id: String) async {
        if let userSession = userSession {
            do {
                try await db.collection("users").document(userSession.uid).collection("FavoriteDogs").document(id).delete()
            } catch {
                print("Error printing favorite dog from firestore")
            }
        }
    }
}
