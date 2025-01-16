//
//  ReceiptListCardDetailAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.01.25.
//

import SwiftUI

struct ReceiptListCardDetailAdmin: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    var receipt: Receipt
    
    var body: some View {
        List(receipt.products) { product in
            HStack {
                ReceiptImageAdmin(product: product)
                
                ProductInfoAdmin(product: product)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
//    ReceiptListCardDetailAdmin()
}
