import SwiftUI

struct ReferenceView: View {
    var body: some View {
        ZStack {
            Color.primary
            VStack {
                Text("API REFERENCES")
                    .font(Font.custom("Marker Felt", size: 30))
                    .fontWeight(.bold)
                    .padding(.top, 70)
                    .padding(.bottom, 30)
                    .foregroundStyle(.white)
                VStack {
                    Text("Cats Data and Photos:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://thecatapi.com")
                }
                .padding(.bottom)
                VStack {
                    Text("Dogs Data and Photos:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://www.thedogapi.com")
                }
                .padding(.bottom)
                VStack {
                    Text("Cat Fact:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://kinduff.github.io/dog-api/")
                }
                .padding(.bottom)
                VStack {
                    Text("Dog Fact:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://github.com/wh-iterabb-it/meowfacts?ref=public_apis")
                }
                .padding(.bottom)
                VStack {
                    Text("Cat Breed Prediction AI:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://universe.roboflow.com/cat-breed/cat-breeds-2n7zk")
                }
                .padding(.bottom)
                VStack {
                    Text("Dog Breed Prediction AI:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://universe.roboflow.com/ai-training-data-dog-seeker/dog-seeker-rppqw")
                }
                .padding(.bottom)
                VStack {
                    Text("ISO Flags:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("https://github.com/gosquared/flags")
                }
                Spacer()
            }
            .padding(30)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ReferenceView()
}
