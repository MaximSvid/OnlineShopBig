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
    @Published var errorMessage: String? = ""// Zeigt eine Nachricht bei Fehlern
    
    private let userViewModel: UserViewModel
    private let userRepository: UserRepository
    
    // Für reale Arbeit
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self.userRepository = UserRepositoryImplementation()
        
    }
    
    // Für Unit-Tests
    init(userViewModel: UserViewModel, userRepository: UserRepository) {
        self.userViewModel = userViewModel
        self.userRepository = userRepository
    }
    
    private let fb = FirebaseService.shared
    private let db = Firestore.firestore()
    
    // Registriert einen neuen Benutzer mit E-Mail
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

            Task {
                do {
                    try await userRepository.registerWithEmail(name: userName, email: email, password: password)
                    self.user =  fb.auth.currentUser
                    await self.userViewModel.createUser(id: self.user?.uid ?? "", name: name, role: role ?? "user")
                    await self.userViewModel.fetchUser(id: self.user?.uid ?? "", name: name, role: role ?? "user")
                    await checkUserRole()
                } catch {
                    errorMessage = "Registration failed: \(error.localizedDescription)"
                }
            }
        }
    
    // Meldet einen Benutzer mit E-Mail an
    func loginWithEmail(completion: @escaping () -> Void) {
            Task {
                do {
                    try await userRepository.loginWithEmail(email: email, password: password)
                    self.user = fb.auth.currentUser
                    await checkUserRole()
                    completion() // Ruft eine Funktion auf, um die Produktanzahl nach erfolgreichem Login zu laden
                } catch let error as NSError {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .invalidEmail:
                        errorMessage = "Invalid email address"
                    case .wrongPassword:
                        errorMessage = "Incorrect password. Please try again."
                    case .networkError:
                        errorMessage = "Network error. Please check your internet."
                    case .userNotFound:
                        errorMessage = "No account found with this email."
                    default:
                        errorMessage = "An unknown error occurred: \(error.localizedDescription)"
                    }
                }
            }
        }
    
    // Prüft, ob der angemeldete Benutzer ein Admin oder User ist
    func checkUserRole() async {
            do {
                try await userRepository.checkUserRole()
                guard let currentUser = FirebaseService.shared.auth.currentUser else { return }
                let document = try await Firestore.firestore().collection("users").document(currentUser.uid).getDocument()
                if let data = document.data(), let userRole = data["role"] as? String {
                    self.role = userRole
                } else {
                    self.role = nil
                }
            } catch {
                print("Error fetching user role: \(error.localizedDescription)")
            }
        }
    
    // Gibt zurück, ob ein Benutzer angemeldet ist
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    // Meldet den Benutzer ab
    func logout() {
        do {
            
            try userRepository.logout()
            self.user = nil
            self.role = nil
            print ("User successfully signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // Prüft, ob ein Benutzer angemeldet ist und aktualisiert die Daten
    func checkIfUserIsLoggenIn() {
            Task {
                do {
                    try await userRepository.checkIfUserIsLoggedIn()
                    self.user = FirebaseService.shared.auth.currentUser
                    await checkUserRole()
                } catch {
                    self.user = nil
                    self.role = nil
                }
            }
        }
}
