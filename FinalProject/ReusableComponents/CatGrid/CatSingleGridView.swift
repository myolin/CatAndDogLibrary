import SwiftUI

struct CatSingleGridView: View {
    var cat: CatModel
    
    var body: some View {
        HStack() {
            Image(cat.referenceImageId ?? "Cat")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .clipped()
            Text(cat.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.indigo)
            Spacer()
            VStack {
                Spacer()
                Text(cat.origin)
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .offset(x: -7, y: -7)
            }
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
