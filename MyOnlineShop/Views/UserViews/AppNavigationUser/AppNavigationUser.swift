//
//  AppNavigationUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationUser: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            UserHomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            CartUser()
                .tabItem {
                    Label("My Cart", systemImage: "cart")
                }
                .tag(1)
            
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "star")
                }
                .tag(2)
            
            UserSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(3)
        }
    }
}


#Preview {
    AppNavigationUser()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
}
