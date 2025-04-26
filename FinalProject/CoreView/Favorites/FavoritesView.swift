import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) var modelContext
    
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var selected = 0
    @State private var isMultiColumn: Bool = true
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: isMultiColumn ? 2 : 1)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker("Names", selection: $selected) {
                    Text("Cat").tag(0)
                    Text("Dog").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        if selected == 0 {
                            ForEach(viewModel.favoriteCats, id: \.self) { cat in
                                NavigationLink(value: cat) {
                                    if isMultiColumn {
                                        CatMultiGridView(cat: cat)
                                    } else {
                                        CatSingleGridView(cat: cat)
                                    }
                                }
                            }
                        } else {
                            ForEach(viewModel.favoriteDogs, id: \.self) { dog in
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
                    .padding(.leading, 4)
                }
                Spacer()
            }
            .navigationTitle("Favorites")
            .toolbarBackground(Color.brown, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                Button {
                    isMultiColumn.toggle()
                } label: {
                    Image(systemName: isMultiColumn ? "rectangle.grid.1x2" : "square.grid.2x2")
                        .symbolVariant(.fill)
                        .foregroundStyle(Color.white)
                }
            }
            .task {
                viewModel.modelContext = modelContext
            }
            .navigationDestination(for: CatModel.self) { cat in
                CatDetailView(cat: cat)
            }
            .navigationDestination(for: DogModel.self) { dog in
                DogDetailView(dog: dog)
            }
            .onAppear {
                viewModel.fetchAllFavoriteFromFirestore()
            }
        }
    }
}

#Preview {
    //FavoritesView()
    let preview = Preview(CatModel.self, DogModel.self)
    preview.addSampleCats(CatModel.sampleCats)
    preview.addSampleDogs(DogModel.sampleDogs)
    return FavoritesView()
        .modelContainer(preview.container)
}


