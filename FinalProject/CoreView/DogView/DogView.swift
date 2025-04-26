import SwiftUI
import SwiftData

struct DogView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \DogModel.name) private var dogs: [DogModel]
    
    @StateObject private var viewModel = DogViewModel()
    @State private var searchTerm = ""
    @State private var isMultiColumn: Bool = true
    @State private var dialogIsActive = false // Custom Dialog for dog fact
    
    var filteredDogs: [DogModel] {
        if searchTerm.isEmpty {
            return dogs
        }
        let filteredDogs = dogs.compactMap { dog in
            let namesContainSearchTerm = dog.name.range(of: searchTerm, options: .caseInsensitive) != nil
            return namesContainSearchTerm ? dog : nil
        }
        return filteredDogs
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: isMultiColumn ? 2 : 1)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredDogs, id: \.id) { dog in
                            NavigationLink(value: dog) {
                                if isMultiColumn {
                                    DogMultiGridView(dog: dog)
                                } else {
                                    DogSingleGridView(dog: dog)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Dog Library")
                .navigationDestination(for: DogModel.self) { dog in
                    DogDetailView(dog: dog)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            Task {
                                await viewModel.getDogFact()
                                dialogIsActive = true
                            }
                        } label: {
                            Image(systemName: "lightbulb.min.badge.exclamationmark.fill")
                                .foregroundStyle(Color.brown)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isMultiColumn.toggle()
                        } label: {
                            Image(systemName: isMultiColumn ? "rectangle.grid.1x2" : "square.grid.2x2")
                                .symbolVariant(.fill)
                                .foregroundStyle(Color.brown)
                        }
                    }
                }
                .animation(.spring(), value: isMultiColumn)
                .padding(.horizontal, 8)
                .padding(.bottom, 5)
                .searchable(text: $searchTerm, prompt: "Search Dog Breeds")
                .overlay {
                    if filteredDogs.isEmpty {
                        ContentUnavailableView.search
                    }
                }
                
                if dialogIsActive {
                    DogFactDialogView(isActive: $dialogIsActive, viewModel: viewModel, message: viewModel.fact)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(DogModel.self)
    preview.addSampleDogs(DogModel.sampleDogs)
    return DogView()
        .modelContainer(preview.container)
}
