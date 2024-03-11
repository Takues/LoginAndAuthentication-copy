//
//  RegistrationView.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email =  " "
    @State private var fullname =  " "
    @State private var password =  " "
    @State private var confirmPassword =  " "
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel

    
    var body: some View {
        VStack {
            Image("Matter-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            
            VStack(spacing: 24) {
                InputView(text:$email, title: "Email Address", placeholder:"name@example.com")
                    .autocapitalization(.none)
                
                InputView(text:$fullname, title: "Full Name", placeholder:"Enter you full name")
                    .autocapitalization(.none)

                
                InputView(text:$password, title: "Password", placeholder:"Enter Your Password", isSecureField: true)
                

                ZStack(alignment: .trailing) {
                    InputView(text:$confirmPassword, title: "Confirm Password", placeholder:"Confirm your password", isSecureField: true)

                    if password.isEmpty && confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }

            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already Have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
            }
        }
    }
}

// Mark- Conforms to 

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

        struct RegistrationView_Previews: PreviewProvider {
            static var previews: some View {
                RegistrationView()
            }
        }


