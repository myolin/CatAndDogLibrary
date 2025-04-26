import SwiftUI
import WebKit

struct DogDetailView: View {
    @EnvironmentObject var authModel: AuthViewModel
    
    var dog: DogModel
    
    @StateObject private var viewModel = BreedDetailViewModel()
    @State private var uiImage = UIImage() // for passing UIImage into expanded view
    @State private var showSheet: Bool = false // image expanded view
    @State private var isFetched = false // time for viewModel to fetchImages within 1 second
    
    var body: some View {
        ScrollView {
            VStack { // Top Level Container
                ZStack { // Image
                    Image(dog.referenceImageId)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                }
                VStack { // Detail Information Container
                    HStack { // name and favorite button
                        Text(dog.name)
                            .font(Font.custom("Marker Felt", size: 32, relativeTo: .title))
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                        Spacer()
                        Button { // favorite button
                            if viewModel.isDogFav {
                                Task {
                                    await viewModel.removeDogFromFavorite(id: String(dog.id))
                                    viewModel.isDogFav = false
                                }
                            } else {
                                viewModel.addDogToFavorite(id: String(dog.id), name: dog.name)
                                viewModel.isDogFav = true
                            }
                        } label : {
                            Image(systemName: viewModel.isDogFav ? "heart.fill" : "heart")
                                .font(.system(size: 30))
                                .foregroundStyle(.mint)
                        }
                    } // name and favorite button
                    .padding([.leading, .top, .trailing])
                    HStack(alignment: .center) { // origin and flag
                        Text("Origin: ")
                            .font(Font.custom("American Typewriter", size: 16))
                            .fontWeight(.bold)
                        Text(dog.origin ?? "Unknown")
                            .font(Font.custom("Comic Sans MS", size: 14))
                        Image(dog.countryCode ?? "_unknown")
                        Spacer()
                    } // origin and flag
                    .padding([.leading, .trailing])
                    HStack(spacing: 40) { // dog weight and height
                        HStack { // dog weight
                            Image("dogweight")
                            VStack(alignment: .leading) {
                                Text("Weight:")
                                    .font(Font.custom("American Typewriter", size: 18))
                                    .fontWeight(.semibold)
                                //Text("weight")
                                Text("\(dog.weight.imperial) lbs")
                                    .font(Font.custom("Comic Sans MS", size: 16))
                            }
                        } // dog weight
                        HStack { // dog height
                            Image("dogheight")
                            VStack(alignment: .leading) {
                                Text("Height:")
                                    .font(Font.custom("American Typewriter", size: 18))
                                    .fontWeight(.semibold)
                                //Text("height")
                                Text("\(dog.height.imperial) inches")
                                    .font(Font.custom("Comic Sans MS", size: 16))
                            }
                        } // dog height
                    } // dog weight and height
                    HStack { // longevity
                        Image("doglifespan")
                        VStack(alignment: .leading) {
                            Text("Longevity:")
                                .font(Font.custom("American Typewriter", size: 18))
                                .fontWeight(.semibold)
                            Text("\(dog.lifeSpan)")
                                .font(Font.custom("Comic Sans MS", size: 16))
                        }
                    } // longevity
                    VStack(alignment: .leading, spacing: 10) { // bred for
                            Text("")
                                .frame(maxWidth: .infinity)
                            Text("Bred For")
                                .font(Font.custom("American Typewriter", size: 18))
                                .fontWeight(.bold)
                            Text(dog.bredFor ?? "No data")
                                .font(Font.custom("Comic Sans MS", size: 16))
                    } // bred for
                    .padding([.leading, .trailing])
                    VStack(alignment: .leading, spacing: 10) { // temperament
                            Text("")
                            .frame(maxWidth: .infinity)
                            Text("Temperament")
                                .font(Font.custom("American Typewriter", size: 18))
                                .fontWeight(.bold)
                            Text(dog.temperament ?? "No data")
                                .font(Font.custom("Comic Sans MS", size: 16))
                    } // temperament
                    .padding([.leading, .trailing, .bottom])
                    VStack(alignment: .leading) { // more photos
                        Text("More Photos...")
                            .font(Font.custom("American Typewriter", size: 18))
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            HStack {
                                if isFetched {
                                    ForEach(viewModel.photoUrl, id: \.self) { urlString in
                                        AsyncImage(url: URL(string: urlString)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: UIScreen.main.bounds.width - 75, height: 250)
                                                    .clipped()
                                                    .onTapGesture {
                                                        let renderer = ImageRenderer(content: image)
                                                        uiImage = renderer.uiImage ?? UIImage()
                                                        showSheet.toggle()
                                                    }
                                            } else if phase.error != nil {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width - 100, height: 250)
                                            } else {
                                                ProgressView()
                                                    .frame(width: UIScreen.main.bounds.width - 100, height: 250)
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .scrollTransition { content, phase in
                                            content
                                                .scaleEffect(
                                                    x: phase.isIdentity ? 1.0 : 0.8,
                                                    y: phase.isIdentity ? 1.0 : 0.8
                                                )
                                                .offset(y: phase.isIdentity ? 0 : 200)
                                        }
                                        .shadow(radius: 10)
                                    }
                                } else {
                                    ProgressView()
                                        .frame(width: UIScreen.main.bounds.width - 100, height: 250)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .contentMargins(20, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                    } // more photos
                    .padding()
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(y: -30)
            }
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSheet) {
            ExpandedPhotoView(uiImage: $uiImage)
        }
        .task {
            await viewModel.getPhotoUrl(id: String(dog.id), endpoint: DataImporter.shared.dogImageEndpoint)
            await viewModel.checkIfDogIsFav(id: String(dog.id))
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isFetched = true
            }
        }
    }
}

#Preview {
    let preview = Preview(DogModel.self, Weight.self, Height.self)
    return NavigationStack {
        DogDetailView(dog: DogModel.sampleDogs[0])
            .modelContainer(preview.container)
    }
}
