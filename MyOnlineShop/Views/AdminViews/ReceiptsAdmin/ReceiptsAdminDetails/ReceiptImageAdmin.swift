//
//  ReceiptListCartDetailAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.01.25.
//

import SwiftUI

struct ReceiptImageAdmin: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
//    var receipt: Receipt
    var product: Product

    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                if !product.images.isEmpty {
                    ForEach(product.images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: product.images[index])) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 100)
                                .cornerRadius(10)
                                .clipped()
                        } placeholder: {
                            Color.gray
                                .frame(width: 70, height: 100)
                        }
                    }
                } else {
                    Image("image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 100)
                        .cornerRadius(10)
                        .clipped()
                }
            }
        }
    }
}
    
