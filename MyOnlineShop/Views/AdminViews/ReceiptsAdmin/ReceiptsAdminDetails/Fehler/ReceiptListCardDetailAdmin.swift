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
        VStack {
//            StatusAdmin()
            
            List(receiptAdminViewModel.receipts) { receipt in
                HStack {
                    ReceiptImageAdmin(receipt: receipt)
                    
                    //                ProductInfoAdmin(product: receipt)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .onAppear {
            Task {
                await receiptAdminViewModel.fetchAllReceipts()
            }
            
        }
    }
}

#Preview {
    //    ReceiptListCardDetailAdmin()
}
