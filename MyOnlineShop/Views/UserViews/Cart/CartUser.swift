//
//  CartUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI

struct CartUser: View {
    var body: some View {
        VStack {
            
            List() {
                
            }
            
            Spacer()
            
            VStack {
                
                HStack {
                    Text("Sum")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text("€ 35")
                        .font(.headline)
                }
                
                Divider()
                
                HStack {
                    Text("Total")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Spacer()
                    
                    Text("€ 35")
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            HStack {
                Button(action: {
                    
                }) {
                    Text("Check Out")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(.blue.opacity(0.8))
                        .clipShape(.buttonBorder)                }
                
                Button(action: {
                    
                }) {
                    Image(systemName: "tag")
                        .font(.headline.bold())
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                        .background(.blue.opacity(0.8))
                        .clipShape(.buttonBorder)
                }
            }
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    CartUser()
}
