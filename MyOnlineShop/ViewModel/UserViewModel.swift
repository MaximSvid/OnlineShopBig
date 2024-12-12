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
    
    func createUser(id: String, name: String) async {
        let newUser = FireUser(
            id: id,
            name: name
        )
        
        do {
            try await db.collection("users").document(id).setData([
                "id": newUser.id,
                "name": newUser.name
            ])
            self.user = newUser
            print("User created \(newUser)")
        } catch {
            print("Error creating user: \(error)")
        }
    }
    
    func fetchUser(id: String, name: String) async {
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
                    name: name
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
