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
    private let userRepository: UserRepository
    
    //для реальной работы
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        self.userRepository = UserRepositoryImplementation()
        
    }
    
    //для unit test
    init(userViewModel: UserViewModel, userRepository: UserRepository) {
        self.userViewModel = userViewModel
        self.userRepository = userRepository
    }
    
//    private let userRepository = UserRepositoryImplementation()
    
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
    
    func loginWithEmail(completion: @escaping () -> Void) {
            Task {
                do {
                    try await userRepository.loginWithEmail(email: email, password: password)
                    self.user = fb.auth.currentUser
                    await checkUserRole()
                    completion() // если пользователь успешно входит добавляю функцию чтобы загрузить количество товара уже при вызове loginWithEmail
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
    
    //func überpruft wer macht login user oder admin
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
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
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
    
//    func loginWithGoogle() {
//        guard let rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController else { return }
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        Task {
//            do {
//                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
//                guard let idToken = result.user.idToken?.tokenString else { return }
//                let accessToken = result.user.accessToken.tokenString
//                let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                let firebaseResult = try await fb.auth.signIn(with: credentials)
//                
//                // Check if user exists here
//                let user = AppUser(id: firebaseResult.user.uid, email: firebaseResult.user.email ?? "")
//                try self.fb.database.collection("users").document(user.id).setData(from: user)
//            } catch {
//                print(error)
//            }
//        }
//    }

}
