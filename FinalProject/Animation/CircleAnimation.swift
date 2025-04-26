import SwiftUI

struct CircleAnimation: View {
    
    @State private var loadingAnimation = 0
    private var offset: CGFloat
    private var width: CGFloat
    private var height: CGFloat
    
    init(offset: CGFloat, width: CGFloat, height: CGFloat){
        self.offset = offset
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.purple).opacity(0.8))
                .offset(x: offset)
                .rotationEffect(.degrees(-45))
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.systemIndigo).opacity(0.8))
                .offset(x: offset)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.systemCyan).opacity(0.8))
                .offset(x: offset)
                .rotationEffect(.degrees(45))
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.blue).opacity(0.8))
                .offset(y: offset)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.green).opacity(0.8))
                .offset(x: -offset)
                .rotationEffect(.degrees(-45))
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.yellow).opacity(0.8))
                .offset(x: -offset)
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.orange).opacity(0.8))
                .offset(x: -offset)
                .rotationEffect(.degrees(45))
            
            Circle()
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(Color(.red).opacity(0.8))
                .offset(y: -offset)
            
        }
        .rotationEffect(.degrees(Double(loadingAnimation)))
        .animation(.linear(duration: 1.8).repeatForever(autoreverses: false), value: loadingAnimation)
        .onAppear(){
            loadingAnimation = 360
        }
    }
}

#Preview {
    CircleAnimation(offset: CGFloat(15), width: CGFloat(7), height: CGFloat(7))
}
