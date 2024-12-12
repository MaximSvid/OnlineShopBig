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
    
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = ""
    
    private let userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }
    
    
    private let fb = FirebaseService.shared
    
    func registerWithEmail(name: String) {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !userName.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords don't match"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long"
            return
        }
        errorMessage = nil
        
        fb.auth.createUser(withEmail: email, password: password) {
            result,
            error in
            if let error {
                print("Error signing up with email: \(error.localizedDescription)")
                return
            }
            
            guard let result else { return }
            print("User signed up with email: \(result.user.uid)")
            
            self.user = result.user
            Task {
                await self.userViewModel.createUser(
                    id: result.user.uid,
                    name: name
                )
                //fetch...
            }
        }
    }
}
