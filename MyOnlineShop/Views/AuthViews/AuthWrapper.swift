//
//  AuthWrapper.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AuthWrapper: View {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var authViewModel = AuthViewModel(userViewModel: UserViewModel())
    @StateObject private var productViewModel = ProductViewModel()
    
    
    var body: some View {
        VStack {
            if authViewModel.userIsLoggedIn {
                if let role = authViewModel.role {
                    if role == "admin" {
                        AppNavigationAdmin()
                    } else {
                        AppNavigationUser()
                    }
                } else {

                    ProgressView()
                }
            } else {
                AuthView()
            }
        }
        
        .environmentObject(authViewModel)
        .environmentObject(userViewModel)
        .environmentObject(productViewModel)
        .onAppear {
            authViewModel.checkIfUserIsLoggenIn()
            }
    }
    
}

#Preview {
    AuthWrapper()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
        .environmentObject(ProductViewModel())
        
}
