//
//  AuthView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import SwiftUI

struct AuthView: View {
    @State private var guestIsPresent: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome \n        to Online Shop")
                    .font(.system(size: 40).bold())
                    .padding([.leading, .trailing])
                    .foregroundStyle(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                NavigationLink (destination: SignInView()) {
                    Text("Sign In")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.green)
                        .clipShape(.buttonBorder)
                }
                .padding([.leading, .trailing])
                
                NavigationLink (destination: RegisterView()) {
                    Text("Register")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.buttonBorder)
                }
                .padding([.leading, .trailing])
                
                Button (action: {
                    
                    
                    
                }) {
                    Text("Login as Guest")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(.buttonBorder)
                }
                .padding([.leading, .trailing])
                .padding(.bottom, 50)
            }
            .animatedGradientBackground()
        }
    }
}

#Preview {
    AuthView()
}
