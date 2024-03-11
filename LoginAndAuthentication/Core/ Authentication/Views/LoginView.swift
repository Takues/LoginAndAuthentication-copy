//
//  LoginView.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    //Have to change it to a Environment Object so it can be used across multiple views within the Application.
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("Matter-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)

                // fore fields
                VStack(spacing: 24) {
                    InputView(text:$email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    

                    InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)

                }
                .padding(.horizontal)
                .padding(.top, 20)

                //Sign in button
                Button {
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow-right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)

                }
                .background(Color(.systemBlue))
                .disabled(formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(30)
                .padding(.top, 24)

                Spacer()
                //Sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text(" Don't Have an account ?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
/*#Preview {
    LoginView()
}
*/

