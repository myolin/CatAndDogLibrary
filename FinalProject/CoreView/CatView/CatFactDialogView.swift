import SwiftUI

struct CatFactDialogView: View {
    @Binding var isActive: Bool

    let viewModel: CatViewModel
    
    @State var message = ""
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
            VStack {
                Text("Cat Fact")
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text(message)
                    .font(.body)
                
                Button {
                    Task {
                        await viewModel.getCatFact()
                        message = viewModel.fact
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.brown)
                        Text("Get Next Fact")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x:0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func dismiss() {
        offset = 1000
        isActive = false
    }
}

#Preview {
    CatFactDialogView(isActive: .constant(true), viewModel: CatViewModel(), message: "Cat Fact Message")
}
