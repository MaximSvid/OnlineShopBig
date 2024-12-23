//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationAdmin: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            Tab("Admin Home", systemImage: "house") {
                AdminHome()
            }
            Tab("Test Imgur", systemImage: "i.circle") {
                ImageUploadView()
            }
            Tab("Admin Settings", systemImage: "gear") {
                AdminSettingsView()
            }
        }
    }
}

#Preview {
    AdminHome()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
}
