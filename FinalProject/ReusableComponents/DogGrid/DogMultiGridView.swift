import SwiftUI

struct DogMultiGridView: View {
    var dog: DogModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(dog.referenceImageId)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 185, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(dog.name)
                    .foregroundStyle(.indigo)
                    .font(.system(size: 20, weight: .bold))
        }
    }
}

#Preview {
    let preview = Preview(DogModel.self)
    return NavigationStack {
        DogMultiGridView(dog: DogModel.sampleDogs[0])
            .modelContainer(preview.container)
    }
}
