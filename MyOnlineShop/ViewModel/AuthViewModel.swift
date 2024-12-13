//
//  AuthViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import SwiftUI
import FirebaseAuth
import Firebase

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var role: String? // admin oder user
    
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = ""// kommt eine message when fehler gibt
    
    private let userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        
    }
    
    private let fb = FirebaseService.shared
    private let db = Firestore.firestore()
    
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
                await self.userViewModel.fetchUser(
                    id: result.user.uid,
                    name: name
                )
                await self.checkUserRole()
            }
        }
    }
    
    func loginWithEmail() {
        fb.auth.signIn(
            withEmail: email,
            password: password
        ) { result , error in
            //bearbeitung fehler von Firebase
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    self.errorMessage = "Invalid email address"
                case .wrongPassword:
                    self.errorMessage = "Incorrect password. Please try again."
                case .networkError:
                    self.errorMessage = "Network error. Please check your internet."
                case .userNotFound:
                    self.errorMessage = "No account found with this email."
                default:
                    self.errorMessage = "An unknown error occurred: \(error.localizedDescription)"
                }
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            guard let result else { return }
            print("Signed in with \(result.user.uid)")
            
            self.user = result.user
            
            Task {
                await self.checkUserRole() // prüfen user / admin
            }
        }
    }
    
    //func überpruft wer macht login user oder admin
    func checkUserRole() async {
        guard let uid = user?.uid else {
            print("User is not logged in")
            return
        }
        do {
            let document = try await db.collection("users").document(uid).getDocument()
            
            if let data = document.data(),
                let userRole = data["role"] as? String {
                await MainActor.run {
                    self.role = userRole
                }
                    
            } else {
                await MainActor.run {
                    self.role = nil // when user keine role hast
                }
            }
            
        } catch {
            print("Error fetching user role: \(error.localizedDescription)")
        }
    }
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    func logout() {
        do {
            guard Auth.auth().currentUser != nil else {
                print("No user is currently logged in")
                return
            }
            try Auth.auth().signOut()
            self.user = nil
            self.role = nil
            print ("User successfully signed out")
        } catch {
            print ("Error signing out: \(error.localizedDescription)")
        }
    }
    
//    func logout() {
//        do {
//            guard fb.userId != nil
//            else {
//                print("No user id")
//                return
//            }
//            
//            try fb.auth.signOut()
//            self.user = nil
//        } catch {
//            print("Error signing out: \(error.localizedDescription)")
//        }
//    }
}
