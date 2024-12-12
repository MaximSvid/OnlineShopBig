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
    @Published var guestUser: FireGuestUser?
    
    private let db = Firestore.firestore()
    
    func createGuestUser(id: String)  async {
        let newGuestUser = FireGuestUser(id: id)
        
        do {
            try await db.collection("guestUsers").document(id).setData([
                "id": newGuestUser.id
            ])
            self.guestUser = newGuestUser
            print("Created new guest user: \(newGuestUser)")
        } catch {
            print("Error creating new guest user: \(error.localizedDescription)")
        }
    }
}
