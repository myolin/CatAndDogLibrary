import SwiftUI
import SwiftData

struct CatView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \CatModel.name) private var cats: [CatModel]
    
    @StateObject private var viewModel = CatViewModel()
    @State private var searchTerm = ""
    @State private var isMultiColumn: Bool = true
    @State private var dialogIsActive = false // Custom Dialog for cat fact
    
    var filteredCats: [CatModel] {
        if searchTerm.isEmpty {
            return cats
        }
        let filteredCats = cats.compactMap { cat in
            let namesContainSearchTerm = cat.name.range(of: searchTerm, options: .caseInsensitive) != nil
            return namesContainSearchTerm ? cat : nil
        }
        return filteredCats
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: isMultiColumn ? 2 : 1)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredCats, id: \.id) { cat in
                            NavigationLink(value: cat) {
                                if isMultiColumn {
                                    CatMultiGridView(cat: cat)
                                } else {
                                    CatSingleGridView(cat: cat)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Cat Library")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            Task {
                                await viewModel.getCatFact()
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
                .navigationDestination(for: CatModel.self) { cat in
                    CatDetailView(cat: cat)
                }
                .animation(.spring(), value: isMultiColumn)
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
                .searchable(text: $searchTerm, prompt: "Search Cat Breeds")
                .overlay {
                    if filteredCats.isEmpty {
                        ContentUnavailableView.search
                    }
                }
                
                if dialogIsActive {
                    CatFactDialogView(isActive: $dialogIsActive, viewModel: viewModel, message: viewModel.fact)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(CatModel.self)
    preview.addSampleCats(CatModel.sampleCats)
    return CatView()
        .modelContainer(preview.container)
}
