//
//  SettingsView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AdminSettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            Text("Admin Settings View")
                .font(.title)
            Button("Logout") {
                authViewModel.logout()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AdminSettingsView()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
    
}
