import SwiftUI

// Top Level View
// Can go to Content View or (SplashView->LoginView) depending
// on user login session
struct ContainerView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showSplash = true
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                if showSplash {
                    SplashView(showSplash: $showSplash)
                } else {
                    LoginView()
                }
            } else {
                ContentView()
            }
        }
    }
}

#Preview {
    ContainerView().environmentObject(AuthViewModel())
}
