//
//  GoogleViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.12.24.
//

//import Foundation
//import Firebase
////import GoogleSignIn
//
//@MainActor
//struct GoogleViewModel: ObservableObject {
//    func googleOauth() async throws {
//        //google sign in
//        guard let clientId = FirebaseApp.app()?.options.clientID else {
//            fatalError("No firebase clientId found")
//        }
//        
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        //get rootView
//        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        guard let rootViewController = scene?.windows.first?.rootViewController
//        else {
//            fatalError("There is no root view controller!")
//        }
//        
//        //google sign in authentication response
//        let result = try await GIDSignIn.sharedInstance.signIn(
//            withPresenting: rootViewController
//        )
//        let user = result.user
//        guard let idToken = user.idToken?.tokenString else {
//            throw AuthenticationError.runtimeError("Unexpected error occurred, please retry")
//        }
//        
//        //Firebase auth
//        let credential = GoogleAuthProvider.credential(
//            withIDToken: idToken, accessToken: user.accessToken.tokenString
//        )
//        try await Auth.auth().signIn(with: credential)
//        
//    }
//    
//    func logout() async throws {
//            GIDSignIn.sharedInstance.signOut()
//            try Auth.auth().signOut()
//        }
//}
//
//enum AuthenticationError: Error {
//    case runtimeError(String)
//}
