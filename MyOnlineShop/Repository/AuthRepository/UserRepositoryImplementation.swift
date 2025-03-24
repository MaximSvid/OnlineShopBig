//
//  UserRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 18.12.24.
//
import SwiftUI
import Firebase


class UserRepositoryImplementation: UserRepository {
    private let fb = FirebaseService.shared

    // Registriert einen neuen Benutzer mit E-Mail, Passwort und Name in Firebase
    func registerWithEmail(name: String, email: String, password: String) async throws {
        let result = try await fb.auth.createUser(withEmail: email, password: password)
        let user = FireUser(
            id: result.user.uid,
            name: name,
            role: "user"
        )
        try fb.database
            .collection("users")
            .document(result.user.uid)
            .setData(from: user)
    }
    
    // Meldet einen Benutzer mit E-Mail und Passwort an
    func loginWithEmail(email: String, password: String) async throws {
        try await fb.auth.signIn(withEmail: email, password: password)
    }
    
    // Überprüft die Rolle des angemeldeten Benutzers
    func checkUserRole() async throws {
        guard let uid = fb.auth.currentUser?.uid else {
                throw NSError(domain: "User not logged in", code: -1)
            }
            
            let document = try await fb.database
                .collection("users")
                .document(uid)
                .getDocument()
            
            guard let data = document.data(),
                  let role = data["role"] as? String else {
                throw NSError(domain: "Role not found", code: -1)
            }
            
            print("User role: \(role)")
    }
    
    // Meldet den aktuellen Benutzer ab
    func logout() throws {
        try fb.auth.signOut()
    }
    
    // Prüft, ob ein Benutzer angemeldet ist, und zeigt dessen Daten
    func checkIfUserIsLoggedIn() async throws {
        guard let currentUser = fb.auth.currentUser else {
                throw NSError(domain: "No user is logged in", code: -1)
            }
            
            let document = try await fb.database
                .collection("users")
                .document(currentUser.uid)
                .getDocument()
            
        guard document.data() != nil else {
                throw NSError(domain: "User data not found", code: -1)
            }
            
            let fireUser = try document.data(as: FireUser.self)
            print("Logged-in user: \(fireUser.name), Role: \(fireUser.role)")
    }

}
