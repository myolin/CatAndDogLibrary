import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack{
            VStack {
                //logo
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 200)
                    .padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $username,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                Button {
                    Task {
                        showingAlert = try await authViewModel.signIn(withEmail: username,
                                                   password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                .alert("Login Failed", isPresented: $showingAlert) {
                    Button("Try Again", role: .cancel) {
                        username = ""
                        password = ""
                    }
                } message: {
                    Text("Please re-check your login credentials")
                }
                
                //sign up button
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don'have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                .padding(.top, 12)
                
                //forget password button
                NavigationLink {
                    ForgetPasswordView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Forget Password?")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                }
                .padding(.top, 12)
                
                Spacer()
            }
            .alert("Login Failed!", isPresented: $showingAlert) {
            } message: {
                Text("Please re-enter your login credentials")
            }
        }
    }
}

//Check if forms entry is valid - checking for empty field and
//email must contain "@" and password length must be greater than 6
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !username.isEmpty
        && username.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView().environmentObject(AuthViewModel())
}
