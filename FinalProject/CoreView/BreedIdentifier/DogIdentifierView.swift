import SwiftUI
import PhotosUI

struct DogIdentifierView: View {
    @StateObject private var viewModel = DogIdentifierViewModel()
    @State private var uiImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var loading: Bool = false
    @State private var showCamera = false
    
    var body: some View {
        ZStack {
            Image("star")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            VStack {
                Text("Dog Breed Identifier")
                    .font(Font.custom("Marker Felt", size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Image(uiImage: (uiImage ?? UIImage(named: "Dog")!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 380, height: 300)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(Color.red)
                        .fontWeight(.semibold)
                    Text("Please only upload Dog photo!")
                        .foregroundStyle(.white)
                }
                HStack(spacing: 20) {
                    Button {
                        Task {
                            await viewModel.getCameraPermission()
                            showCamera.toggle()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 40)
                    }
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .fullScreenCover(isPresented: $showCamera) {
                        CameraView(selectedImage: $uiImage)
                            .ignoresSafeArea()
                    }
                    
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                        HStack {
                            Image(systemName: "photo.circle")
                            Text("Photo")
                        }
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 40)
                    }
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onChange(of: photosPickerItem) { _, _ in
                        viewModel.state = true
                        Task {
                            if let photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    self.uiImage = image
                                    await viewModel.analyze(uiImage: image)
                                }
                            }
                            photosPickerItem = nil
                        }
                    }
                }
                .padding(.top)
                VStack {
                    Text("Breed Identified:")
                        .frame(maxWidth: .infinity)
                    if viewModel.state {
                        CircleAnimation(offset: CGFloat(15), width: CGFloat(7), height: CGFloat(7))
                            .frame(width: 40, height: 40)
                    } else {
                        Text(viewModel.breedResult)
                            .font(Font.custom("Marker Felt", size: 40))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.indigo)
                    }
                    HStack {
                        Text("Confidence Level:")
                        if viewModel.state {
                            CircleAnimation(offset: CGFloat(8), width: CGFloat(4), height: CGFloat(4))
                        } else {
                            Text("\(viewModel.confidence)%")
                                .foregroundStyle(Color.red)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .frame(height: 150)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DogIdentifierView()
}
