import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false
    @State private var animatedGradient = false
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animatedGradient ? 45 : 0))
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                            animatedGradient.toggle()
                        }
                    }
                
                List {
                    Section {
                        HStack {
                            if let user = viewModel.currentUser {
                                Text(user.initials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 72, height: 72)
                                    .background(Color(.systemGray3))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.fullname)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.top, 4)
                                    
                                    Text(user.email)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    
                    Section("General") {
                        //version info
                        HStack {
                            ProfileRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    
                    Section("Reference") {
                        //API References
                        NavigationLink {
                            ReferenceView()
                        } label: {
                            ProfileRowView(imageName: "book.circle", title: "API", tintColor: Color(.systemBlue))
                        }
                    }
                    
                    Section("Account") {
                        //change password button
                        Button {
                            print("User Change password..")
                        } label: {
                            ProfileRowView(imageName: "lock.rotation", title: "Change Password", tintColor: Color(.green))
                        }
                        
                        //sign out button
                        Button {
                            viewModel.signOut()
                        } label: {
                            ProfileRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                        }
                        
                        //delete account button
                        Button {
                            viewModel.deleteAccount()
                            showingAlert = true
                        } label: {
                            ProfileRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color(.purple))
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Account Termination"),
                                message: Text("Your account is deleted. Please sign up again for future uses."))
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
            }
            //.ignoresSafeArea()
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
