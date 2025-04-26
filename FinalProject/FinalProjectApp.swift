import SwiftUI
import SwiftData
import Firebase

@main
struct FinalProjectApp: App {
    @StateObject var authViewModel = AuthViewModel()
    private let container = try! ModelContainer(for: CatModel.self, DogModel.self, Weight.self, Height.self)
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .environmentObject(authViewModel)
                .task {
                    await importBreeds()
                }
        }
        .modelContainer(container)
        
    }
    
    // Fetch all data from api and inject them into swiftdata
    @MainActor
    private func importBreeds() async {
        let context = container.mainContext
        do {
            let cats = try await DataImporter.shared.loadCats()
            if !cats.isEmpty {
                cats.forEach { context.insert($0) }
            }
            let dogs = try await DataImporter.shared.loadDogs()
            if !dogs.isEmpty {
                dogs.forEach { context.insert($0) }
            }
        } catch CustomError.invalidURL {
            print("Invalid URL")
        } catch CustomError.invalidResponse {
            print("Invalid Data")
        } catch CustomError.invalidData {
            print("Invalid Data")
        } catch {
            print("Unexpected Error")
        }
    }
}
