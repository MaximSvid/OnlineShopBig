//
//  UserViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: FireUser?
    
    private let db = Firestore.firestore()
    
    // Erstellt einen neuen Benutzer in Firestore
    func createUser(id: String, name: String, role: String) async {
        let newUser = FireUser(
            id: id,
            name: name,
            role: role
        )
        
        do {
            try await db.collection("users").document(id).setData([
                "id": newUser.id,
                "name": newUser.name,
                "registeredOn": Timestamp(date: newUser.registeredOn),
                "role": "user"
            ])
            self.user = newUser
            print("User created \(newUser)")
        } catch {
            print("Error creating user: \(error)")
        }
    }
    
    // Ruft die Daten eines Benutzers aus Firestore ab
    func fetchUser(id: String, name: String, role: String) async {
        do {
            let document = try await
            db.collection("users").document(id).getDocument()
            if let data = document.data(),
               let id = data["id"] as? String,
               let name = data["name"] as? String,
               let registeredOn = data["registeredOn"] as? Timestamp {
                let loadedUser = FireUser(
                    id: id,
                    registeredOn: registeredOn.dateValue(),
                    name: name,
                    role: role
                )
                
                self.user = loadedUser
                print("User fetched \(loadedUser)")
            } else {
                print("User not found")
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
}
