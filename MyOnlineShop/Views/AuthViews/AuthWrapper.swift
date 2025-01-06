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
    @StateObject private var userProductViewModel = UserProductViewModel()
    @StateObject private var imgurProductViewModel = ImgurViewModel()
    @StateObject private var bannerViewModel = BannerViewModel()
    @StateObject private var userCartViewModel = UserCartViewModel()
    
    
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
        .environmentObject(userProductViewModel)
        .environmentObject(imgurProductViewModel)
        .environmentObject(bannerViewModel)
        .environmentObject(userCartViewModel)
        .onAppear {
            authViewModel.checkIfUserIsLoggenIn()
            }
    }
    
}

#Preview {
    AuthWrapper()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
        .environmentObject(ProductViewModel())
        .environmentObject(UserProductViewModel())
        .environmentObject(ImgurViewModel())
        .environmentObject(BannerViewModel())
        .environmentObject(UserCartViewModel())
        
}

