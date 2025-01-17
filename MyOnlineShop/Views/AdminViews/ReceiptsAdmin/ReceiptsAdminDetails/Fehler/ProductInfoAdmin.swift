//
//  ProductInfoAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.01.25.
//

import SwiftUI

struct ProductInfoAdmin: View {
//    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    var product: Product
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.callout)
                    .padding(.top, 10)
                    .foregroundStyle(.gray)
                Spacer()
                HStack {
                    if product.action && product.actionPrice > 0.0 {
                        // main price mit linie
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                            .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                            .strikethrough(true, color: .gray)
                        
                        Text(String(format: "€%.2f", product.actionPrice))
                            .font(.caption)
                            .foregroundStyle(.red)
                    } else {
                        // Nur main price
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                            .foregroundStyle(product.isVisible ? .black : .gray)
                    }
                    Spacer()
                }
                .padding(.trailing, 4)
                .padding(.leading, 4)
                .padding(.bottom, 4)
            }
            Spacer()
        }
    }
}

