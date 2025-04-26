import SwiftUI

enum Tab: String {
    case cat = "cat.circle"
    case dog = "dog.circle"
    case favorites = "heart.circle"
    case profile = "person.circle"
    case catIdentify
    case dogIdentify
}

struct CustomTabBar: View {
    @Binding var currentTab: Tab
    
    private var fillImage: String {
        currentTab.rawValue + ".fill"
    }
    
    @State private var showPopUp = false
    
    var body: some View {
        ZStack {
            if showPopUp {
                HStack(spacing: 50) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.black))
                            .frame(width: 50, height: 50)
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Image("cat_icon_50")
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        currentTab = Tab.catIdentify
                        showPopUp = false
                    }
                    ZStack {
                        Circle()
                            .foregroundColor(Color(.black))
                            .frame(width: 50, height: 50)
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Image("dog_icon_50")
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        currentTab = Tab.dogIdentify
                        showPopUp = false
                    }
                }
                .offset(y: -80)
            }
            HStack {
                Spacer()
                Image(systemName: currentTab == Tab.cat ? fillImage : Tab.cat.rawValue)
                    .scaleEffect(currentTab == Tab.cat ? 1.5 : 1.0)
                    .foregroundStyle(currentTab == Tab.cat ? .brown : .gray)
                    .font(.system(size: 25))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            currentTab = Tab.cat
                        }
                    }
                    .offset(y: -10)
                Spacer()
                Image(systemName: currentTab == Tab.dog ? fillImage : Tab.dog.rawValue)
                    .scaleEffect(currentTab == Tab.dog ? 1.5 : 1.0)
                    .foregroundStyle(currentTab == Tab.dog ? .brown : .gray)
                    .font(.system(size: 25))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            currentTab = Tab.dog
                        }
                    }
                    .offset(y: -10)
                Spacer()
                Circle()
                    .fill(Color.blue)
                    .foregroundStyle(.white)
                    .frame(width: 70, height: 70)
                    .offset(y: -22)
                Spacer()
                Image(systemName: currentTab == Tab.favorites ? fillImage : Tab.favorites.rawValue)
                    .scaleEffect(currentTab == Tab.favorites ? 1.5 : 1.0)
                    .foregroundStyle(currentTab == Tab.favorites ? .brown : .gray)
                    .font(.system(size: 25))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            currentTab = Tab.favorites
                        }
                    }
                    .offset(y: -10)
                Spacer()
                Image(systemName: currentTab == Tab.profile ? fillImage : Tab.profile.rawValue)
                    .scaleEffect(currentTab == Tab.profile ? 1.5 : 1.0)
                    .foregroundStyle(currentTab == Tab.profile ? .brown : .gray)
                    .font(.system(size: 25))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            currentTab = Tab.profile
                        }
                    }
                    .offset(y: -10)
                Spacer()
                
            }
            .frame(width: nil, height: 70)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                ZStack {
                    Circle()
                        .fill(.black)
                        .foregroundStyle(.white)
                        .frame(width: 70, height: 70)
                    Image(systemName: "camera.viewfinder")
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .font(.system(size: 30))
                        .rotationEffect(Angle(degrees: showPopUp ? 360 : 0))
                }
                .offset(x: 0, y: -22)
                .shadow(radius: 6)
                .onTapGesture {
                    withAnimation {
                        showPopUp.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    CustomTabBar(currentTab: .constant(Tab.cat))
}
