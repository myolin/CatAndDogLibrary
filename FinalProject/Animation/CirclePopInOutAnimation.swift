import SwiftUI

struct CirclePopInOutAnimation: View {
    @State private var gradualOpacityAnimation = 0.5
    @State private var gradualScaleAnimation: CGFloat = 1.0
    private var offset = CGFloat(120)
    private var width = CGFloat(40)
    private var height = CGFloat(40)
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.red))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(y: gradualOpacityAnimation == 0.5 ? 0 : -offset)
                .animation(.easeOut(duration: 0.25), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.orange))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(x: gradualOpacityAnimation == 0.5 ? 0 : offset)
                .rotationEffect(.degrees(-45))
                .animation(.easeOut(duration: 0.25).delay(0.25), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.yellow))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(x: gradualOpacityAnimation == 0.5 ? 0 : offset)
                .animation(.easeOut(duration: 0.25).delay(0.5), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.green))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(x: gradualOpacityAnimation == 0.5 ? 0 : offset)
                .rotationEffect(.degrees(45))
                .animation(.easeOut(duration: 0.25).delay(0.75), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.blue))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(y: gradualOpacityAnimation == 0.5 ? 0 : offset)
                .animation(.linear(duration: 0.25).delay(1), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.cyan))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(y: gradualOpacityAnimation == 0.5 ? 0 : offset)
                .rotationEffect(.degrees(45))
                .animation(.easeOut(duration: 0.25).delay(1.25), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.systemIndigo))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(x: gradualOpacityAnimation == 0.5 ? 0 : -offset)
                .animation(.easeOut(duration: 0.25).delay(1.5), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.purple))
                .opacity(gradualOpacityAnimation)
                .scaleEffect(gradualScaleAnimation)
                .offset(y: gradualOpacityAnimation == 0.5 ? 0 : -offset)
                .rotationEffect(.degrees(-45))
                .animation(.easeOut(duration: 0.25).delay(1.75), value: gradualOpacityAnimation)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.9607843137, blue: 0.6705882353, alpha: 1)))
        }
        .onAppear(){
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                gradualOpacityAnimation = gradualOpacityAnimation == 1.0 ? 0.5 : 1.0
                gradualScaleAnimation = gradualScaleAnimation == 1.0 ? 1.0 : 0.5
            }
        }
    }
}

#Preview {
    CirclePopInOutAnimation()
}
