import Foundation
import SwiftData

// Preview container for help displaying swiftdata model
struct Preview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create preview container")
        }
    }
    
    // add the sample cats to simulated model container for preview
    // sample data will be stored in memory only
    func addSampleCats(_ samples: [any PersistentModel]) {
        Task { @MainActor in
            samples.forEach { sample in
                container.mainContext.insert(sample)
            }
        }
    }
    
    // add the sample dogs to simulated model container for preview
    // sample data will be stored in memory only
    func addSampleDogs(_ samples: [any PersistentModel]) {
        Task { @MainActor in
            samples.forEach { sample in
                container.mainContext.insert(sample)
            }
        }
    }
}
