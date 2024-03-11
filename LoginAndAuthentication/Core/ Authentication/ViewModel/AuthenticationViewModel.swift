//
//  AuthenticationViewModal.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 7/3/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    

    init() {
        self.userSession = Auth.auth().currentUser

        Task {
            await fetchUser()
        }
    }

    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }

    }

    //Asynchronous function that can potentially throw an error if anything goes wrong
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            //Create a user using Firebase core
            let results = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = results.user
            // If we get our results back we going to set our properties
            let user = User(id: results.user.uid, fullname:  fullname, email: email)
            // Then encode that object through the codable protocol.
            let encodedUser = try Firestore.Encoder().encode(user)
            // This is how we got our information to be uploaded onto Firebase
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
            // Fetching data uploaded to firebase to properly be displayed in our app
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with: \(error.localizedDescription)")
        }

    }

    func signOut() {
        do {
            try Auth.auth().signOut()// sign out usser on backend
            self.userSession = nil // wipes outb user and takes them to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }

    func deleteAccount() {

    }

    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)

    }
}
