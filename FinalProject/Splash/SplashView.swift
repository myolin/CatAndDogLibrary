import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CirclePopInOutAnimation()
            Image("splash_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 4)) { //1.5
                scale = CGSize(width: 1, height: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.6, execute: { //2.5
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                    
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.3, execute: { //2.9
                withAnimation(.easeIn(duration: 0.35)) {
                    showSplash.toggle()
                }
            })
        }
    }
}

#Preview {
    SplashView(showSplash: .constant(true))
}
