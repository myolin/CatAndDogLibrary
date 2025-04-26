import SwiftUI

struct DogSingleGridView: View {
    var dog: DogModel
    
    var body: some View {
        HStack() {
            Image(dog.referenceImageId)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .clipped()
            Text(dog.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.indigo)
            Spacer()
        }
        .border(Color.brown, width: 4)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.trailing, 10)
    }
}

#Preview {
    let preview = Preview(CatModel.self)
    return NavigationStack {
        CatSingleGridView(cat: CatModel.sampleCats[0])
            .modelContainer(preview.container)
    }
}
