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
                
                if !paymentMethod.description.isEmpty {
                    Text(paymentMethod.description)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Text(paymentMethod.isVisible ? "Visible" : "Hidden")
                    .font(.callout)
                    .foregroundStyle(
                        paymentMethod.isVisible ? .green: .red
                    )
                
                Button(action: {
                    paymentAdminViewModel.toggleVisibility(for: paymentMethod)
                }) {
                    Image(systemName: paymentMethod.isVisible ? "eye" : "eye.slash")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(
                            paymentMethod.isVisible ? .green: .gray
                        )
                }
                .padding(.trailing)
            }
        }
    }
}

#Preview {
//    PaymentListAdmin()
}
