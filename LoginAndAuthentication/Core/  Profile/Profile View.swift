//
//  Profile View.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 7/3/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(User.MOCK_USER.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(User.MOCK_USER.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)

                            Text(User.MOCK_USER.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }

                    Section ("General") {
                        HStack {
                            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))

                            Spacer()

                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                    }

                    }

                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: Color(.red))
                    }
                        Button {
                            print("Delete account..")
                        } label: {
                            HStack {
                                SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color(.systemGray))
                        }
                        }
                    }

                    }
                }
            }
        }
    }

    #Preview {
        ProfileView()
    }


