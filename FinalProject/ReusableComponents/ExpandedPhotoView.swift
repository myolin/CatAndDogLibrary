import SwiftUI

struct ExpandedPhotoView: View {
    @Binding var uiImage: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    ExpandedPhotoView(uiImage: .constant(UIImage(imageLiteralResourceName: "catplaceholder")))
}
