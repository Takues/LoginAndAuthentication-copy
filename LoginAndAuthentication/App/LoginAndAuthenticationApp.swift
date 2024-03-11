//
//  LoginAndAuthenticationApp.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI
import Firebase

@main
struct LoginAndAuthenticationApp: App {
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
