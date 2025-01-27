//
//  PaymentListAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI

struct PaymentListAdmin: View {
    @EnvironmentObject var paymentAdminViewModel: PaymentAdminViewModel
    var paymentMethod: PaymentMethod
    var body: some View {
        HStack {
            if !paymentMethod.image.isEmpty {
                AsyncImage(url: URL(string: paymentMethod.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 50)
                }
            } else {
                Image("image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .clipped()
            }
            
            VStack {
                Text(paymentMethod.name)
                    .font(.headline)
                    .foregroundStyle(paymentMethod.isVisible ? .black : .gray)
                
                if !paymentMethod.description.isEmpty {
                    Text(paymentMethod.description)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
            
            if paymentMethod.isVisible {
                Text("Active")
                    .font(.caption)
                    .foregroundColor(.green)
                    .bold()
            } else {
                Text("Inactive")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .bold()
            }
            
            Button(action: {
                paymentAdminViewModel.toggleVisibility(for: paymentMethod)
            }) {
                Image(systemName: paymentMethod.isVisible ? "eye" : "eye.slash")
                    .foregroundStyle(paymentMethod.isVisible ? .green : .gray)
                    .padding(8)
            }
            .buttonStyle(.bordered)
           
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        
    }
}

#Preview {
    //    PaymentListAdmin()
}
