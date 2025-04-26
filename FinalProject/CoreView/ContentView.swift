import SwiftUI

// Tab Container
struct ContentView: View {
    @State private var currentTab: Tab = .cat
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $currentTab) {
                    switch currentTab {
                    case .cat:
                        CatView()
                    case .dog:
                        DogView()
                    case .favorites:
                        FavoritesView()
                    case .profile:
                        ProfileView()
                    case .catIdentify:
                        CatIdentifierView()
                    case .dogIdentify:
                        DogIdentifierView()
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBar(currentTab: $currentTab)
                    .background(.thinMaterial)
            }
            .ignoresSafeArea(.all)
        }
//        TabView(selection: $currentTab) {
//            Group {
//                CatView()
//                    .tabItem {
//                        Text("") //placeholder to position image
//                        Image("cat_icon_60")
//                    }
//                    .tag(Tab.cat)
//
//                DogView()
//                    .tabItem {
//                        Text("") //placeholder to position image
//                        Image("dog_icon_60")
//                    }
//                    .tag(Tab.dog)
//
//                FavoritesView()
//                    .tabItem {
//                        Text("") //placeholder to position image
//                        Image("favorites_icon_60")
//                    }
//
//                ProfileView()
//                    .tabItem {
//                        Text("") //placeholder to position image
//                        Image("profile_icon_45")
//                    }
//                    .tag(Tab.profile)
//            }
//            .toolbarBackground(Color.brown, for: .tabBar)
//            .toolbarBackground(.visible, for: .tabBar)
//        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
