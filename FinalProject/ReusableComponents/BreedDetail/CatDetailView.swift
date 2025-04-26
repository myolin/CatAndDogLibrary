import SwiftUI
import WebKit

struct CatDetailView: View {
    @EnvironmentObject var authModel: AuthViewModel
    
    var cat: CatModel
    
    @StateObject private var viewModel = BreedDetailViewModel()
    @State private var uiImage = UIImage() // for passing UIImage into expanded view
    @State private var showSheet: Bool = false // image expanded view
    @State private var isFetched = false // time for viewModel to fetchImages within 2 second
    @State private var showWiki = false // wikipedia website
    @State private var showVetStreet = false // VetStreet website
    @State private var showVCA = false // VCAHospital website
    
    var body: some View {
        ScrollView {
            VStack { // Top Level Container
                ZStack { // Image
                    Image(cat.referenceImageId ?? "catplaceholder")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                }
                VStack { // Detail Information Container
                    HStack { // name and favorite button
                        Text(cat.name)
                            .font(Font.custom("Marker Felt", size: 32, relativeTo: .title))
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                        Spacer()
                        Button { // favorite button
                            if viewModel.isCatFav {
                                Task {
                                    await viewModel.removeCatFromFavorite(id: cat.id)
                                    viewModel.isCatFav = false
                                }
                            } else {
                                viewModel.addCatToFavorite(id: cat.id, name: cat.name)
                                viewModel.isCatFav = true
                            }
                        } label: {
                            Image(systemName: viewModel.isCatFav ? "heart.fill" : "heart")
                                .font(.system(size: 30))
                                .foregroundStyle(.mint)
                        }
                    } // name and favorite button
                    .padding([.leading, .top, .trailing])
                    HStack(alignment: .center) { // origin and flag
                        Text("Origin: ")
                            .font(Font.custom("American Typewriter", size: 16))
                            .fontWeight(.bold)
                        Text(cat.origin)
                            .font(Font.custom("Comic Sans MS", size: 14))
                        Image(cat.countryCode)
                        Spacer()
                    } // origin and flag
                    .padding([.leading, .trailing])
                    HStack(spacing: 40) { // lap and weight
                        HStack { // is lap cat
                            Image("lapcat")
                            VStack(alignment: .leading) {
                                Text("Lap Cat:")
                                    .font(Font.custom("American Typewriter", size: 18))
                                    .fontWeight(.semibold)
                                if cat.lap == 1 {
                                    Text("Yes")
                                        .font(Font.custom("Comic Sans MS", size: 16))
                                } else {
                                    Text("No")
                                        .font(Font.custom("Comic Sans MS", size: 16))
                                }
                            }
                        } // is lap cat
                        HStack { // cat weight
                            Image("catweight")
                            VStack(alignment: .leading) {
                                Text("Weight:")
                                    .font(Font.custom("American Typewriter", size: 18))
                                    .fontWeight(.semibold)
                                Text("\(cat.weight.imperial) lbs")
                                //Text("weight")
                                    .font(Font.custom("Comic Sans MS", size: 16))
                            }
                        } // cat weight
                    } // lapcat and weight
                    HStack { // longevity
                        Image("catlifespan")
                        VStack(alignment: .leading) {
                            Text("Longevity:")
                                .font(Font.custom("American Typewriter", size: 18))
                                .fontWeight(.semibold)
                            Text("\(cat.lifeSpan) years")
                                .font(Font.custom("Comic Sans MS", size: 16))
                        }
                    } // longevity
                    VStack(alignment: .leading, spacing: 10) { // temperament
                        Text("")
                            .frame(maxWidth: .infinity)
                        Text("Temperament")
                            .font(Font.custom("American Typewriter", size: 18))
                            .fontWeight(.bold)
                        Text(cat.temperament)
                            .font(Font.custom("Comic Sans MS", size: 16))
                    } // temperament
                    .padding([.leading, .trailing, .bottom])
                    VStack(alignment: .leading, spacing: 10) { // description
                        Text("Description")
                            .font(Font.custom("American Typewriter", size: 18))
                            .fontWeight(.bold)
                        Text(cat.desc)
                            .font(Font.custom("Comic Sans MS", size: 16))
                    } // description
                    .padding([.leading, .trailing, .bottom])
                    VStack(alignment: .leading, spacing: 10) { // characteristics
                        Text("Characteristics")
                            .font(Font.custom("American Typewriter", size: 18))
                            .fontWeight(.bold)
                        HStack { // intelligence
                            Text("Intelligence")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.intelligence)")
                        } // intelligence
                        HStack { // shedding level
                            Text("Shedding Level")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.sheddingLevel)")
                        } // shedding level
                        HStack { // playfulness
                            Text("Playfulness")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.energyLevel)")
                        } // playfulness
                        HStack { // affectionate
                            Text("Affectionate")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.affectionLevel)")
                        } // affectionate
                        HStack { // general health
                            Text("General Health")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.healthIssues)")
                        } // general health
                        HStack { // kids friendly
                            Text("Kids Friendly")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.childFriendly)")
                        } // kids friendly
                        HStack { // dog friendly
                            Text("Dog Friendly")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.dogFriendly)")
                        } // dog friendly
                        HStack { // meowing
                            Text("Meowing")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.vocalisation)")
                        } // meowing
                        HStack { // groom
                            Text("Easy To Groom")
                                .font(Font.custom("Comic Sans MS", size: 16))
                            Spacer()
                            Image("\(cat.grooming)")
                        } // groom
                    } // characteristics
                    .padding([.leading, .trailing])
                    HStack() { // wikipedia, vetstreet, vcahospitals
                        Button {
                            showWiki.toggle()
                        } label: {
                            Image("wikipedia")
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        Spacer()
                        Button {
                            showVCA.toggle()
                        } label: {
                            Image("vcahospital")
                                .clipShape(Circle())
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        Spacer()
                        Button {
                            showVetStreet.toggle()
                        } label: {
                            Image("vetstreet")
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    } // wikipedia, vetstreet, vcahospitals
                    .padding(.top, 32)
                    .padding(.bottom, 16)
                    .padding([.leading, .trailing])
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
        .sheet(isPresented: $showWiki) {
            if let wikipediaUrl = cat.wikipediaUrl {
                WebContentView(url: wikipediaUrl)
            }
        }
        .sheet(isPresented: $showVCA) {
            if let vcahospitalsUrl = cat.vcahospitalsUrl {
                WebContentView(url: vcahospitalsUrl)
            }
        }
        .sheet(isPresented: $showVetStreet) {
            if let vetstreetUrl = cat.vetstreetUrl {
                WebContentView(url: vetstreetUrl)
            }
        }
        .task {
            await viewModel.getPhotoUrl(id: cat.id, endpoint: DataImporter.shared.catImageEndpoint)
            await viewModel.checkIfCatIsFav(id: cat.id)
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isFetched = true
            }
        }
    }
}

#Preview {
    let preview = Preview(CatModel.self, Weight.self)
    return NavigationStack {
        CatDetailView(cat: CatModel.sampleCats[0])
            .modelContainer(preview.container)
        
    }
}
