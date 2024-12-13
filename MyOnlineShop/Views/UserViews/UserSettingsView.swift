//
//  UserSettingsView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct UserSettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            Text("User Settings View")
                .font(.title)
            Button("Logout") {
                authViewModel.logout()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    UserSettingsView()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
    
}
