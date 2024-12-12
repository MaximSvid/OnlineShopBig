//
//  RegisterView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import SwiftUI

struct CreateAccount: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                TextField("Name", text: $authViewModel.userName)
                    .textFieldStyle(.plain)
                    .padding(.bottom, 8)
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                    )
                    .padding(.bottom)
                
                TextField("Email", text: $authViewModel.email)
                    .textFieldStyle(.plain)
                    .padding(.bottom, 8)
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                    )
                    .padding(.bottom)
                
                TextField("Password", text: $authViewModel.password)
                    .textFieldStyle(.plain)
                    .padding(.bottom, 8)
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                    )
                    .padding(.bottom)
                
                TextField("Password", text: $authViewModel.confirmPassword)
                    .textFieldStyle(.plain)
                    .padding(.bottom, 8)
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                    )
                    .padding(.bottom)
                
                
                Button (action: {
                    
                }) {
                    Text("Login")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.green.opacity(0.8))
                        .clipShape(.buttonBorder)
                }
                .padding(.bottom)
                .shadow(radius: 3)
                
                NavigationLink(
                    destination: AuthView()) {
                        Text("Don't have an account? ")
                            .foregroundStyle(.gray)
                        + Text("Sign up")
                            .foregroundStyle(.green)
                    }
                    .padding(.bottom, 30)
                
                HStack {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundStyle(.gray.opacity(0.4))
                    Text("Or")
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 8)
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundStyle(.gray.opacity(0.4))
                }
                .padding(.bottom, 30)
                
                Button (action: {
                    
                }) {
                    HStack {
                        Image("facebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading)
                        
                        Text("Sign In with facebook")
                            .font(.headline.bold())
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.buttonBorder)
                .shadow(radius: 3)
                .padding(.bottom)
                
                Button (action: {
                    
                }) {
                    HStack {
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading)
                        
                        Text("Sign In with Google")
                            .font(.headline.bold())
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(.buttonBorder)
                .shadow(radius: 3)
                .padding(.bottom)
                
                Button (action: {
             
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading)
                        Text("Sign In with Apple")
                            .font(.headline.bold())
                        
                        Spacer()
                    }
                   
                        
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(.white)
                .background(.black)
                .clipShape(.buttonBorder)
                .shadow(radius: 3)
                .padding(.bottom, 40)
            }
            .navigationTitle("Online Shop")
            .padding([.leading, .trailing])
            
        }
    }
}

#Preview {
    CreateAccount(authViewModel: AuthViewModel())
}
