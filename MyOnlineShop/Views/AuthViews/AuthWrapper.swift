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
    
    
    var body: some View {
        VStack {
            if let role = authViewModel.role {
                if role == "admin" {
                    AppNavigationAdmin()
                } else {
                    AppNavigationUser()
                }
            } else {
                AuthView()
            }
        }
        .environmentObject(authViewModel)
        .environmentObject(userViewModel)
        .onAppear {
                if authViewModel.user != nil {
                    Task {
                        await authViewModel.checkUserRole()
                    }
                }
            }
    }
    
}

#Preview {
    AuthWrapper()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
        
}
