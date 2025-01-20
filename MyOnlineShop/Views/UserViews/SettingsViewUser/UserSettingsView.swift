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
            List {
                Section(header: Text("Profile")) {
                    NavigationLink(destination: SettingsProfileUser() ) {
                        Text("User first name and last name")
                            .font(.subheadline)
                    }
                }
                
                Section {
                    
                } header: {
                    Button ("Logout") {
                        authViewModel.logout()
                    }
                    
                }


            }
            .navigationTitle(Text("Settings").font(.title.bold()))
        
        }
        
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
