//
//  PaymentMethodeUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI

struct PaymentMethodeUser: View {
    let payment: PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundStyle(isSelected ? Color.primaryBrown : Color.secondaryGray)
                
                if !payment.image.isEmpty {
                    AsyncImage(url: URL(string: payment.image)) { image in
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

                
                VStack(alignment: .leading, spacing: 4) {
                    Text(payment.name)
                        .font(.headline)
//                        .foregroundStyle(.black)
                    
                    if !payment.description.isEmpty {
                        Text(payment.description)
                            .font(.caption)
                            .foregroundStyle(Color.secondaryGray)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.backgroundColor)
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
//    PaymentMethodeUser()
}
