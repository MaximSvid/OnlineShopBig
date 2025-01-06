//
//  AppNavigationUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationUser: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                UserHomeView()
            }
            Tab("My Cart", systemImage: "cart") {
                CartUser()
            }
            Tab("Favorite", systemImage: "star"){
                Favorite()
            }
            Tab("Settings", systemImage: "gearshape") {
                UserSettingsView()
            }
        }
    }
}

#Preview {
    AppNavigationUser()
         .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
}
