//
//  AuthViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    
    private let fb = FirebaseService.shared
    
    
    func loginAsGuest() {
        fb.auth.signInAnonymously { result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let result else { return }
            print("User signed in as guest: \(result.user.uid)")
            
            self.user = result.user
        }
    }
}
