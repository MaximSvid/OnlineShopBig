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
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: SettingsProfileUser() ) {
                        HStack {
                            Image(systemName: "person")
                                .font(.subheadline)
                            Text("User first name and last name")
                                .font(.subheadline)
                            Spacer()
                        }
                        
                    }
                } header: {
                    Text("Profile")
                }

                Section {
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.subheadline)
                            Text("Logout")
                                .font(.subheadline)
                            
                            Spacer()
                        }
                        .foregroundStyle(.red)
                    }
                } header: {
                    Text("Logout")
                }

            }
            .navigationTitle(Text("Settings").font(.title.bold()))
        }
    }
}

#Preview {
    UserSettingsView()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
    
}
