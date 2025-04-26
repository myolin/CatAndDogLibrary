import SwiftUI

struct CatMultiGridView: View {
    var cat: CatModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(cat.referenceImageId ?? "Cat")
                .resizable()
                .scaledToFill()
                .frame(width: 185, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(cat.name)
                .foregroundStyle(.indigo)
                .font(.system(size: 20, weight: .bold))
            
        }
    }
}

#Preview {
    let preview = Preview(CatModel.self)
    return NavigationStack {
        CatMultiGridView(cat: CatModel.sampleCats[0])
            .modelContainer(preview.container)
    }
}
