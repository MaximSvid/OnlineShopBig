//
//  ReceiptListAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.01.25.
//

import SwiftUI

struct AdminReceiptsList: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    var receipt: Receipt
    var body: some View {
        HStack {
            ReceiptImageAdmin(receipt: receipt)
            
            ReceiptsStatus(receipt: receipt) { newStatus in
                Task {
                    await receiptAdminViewModel.updateOrderStatus(
                        for: receipt,
                        newStatus: newStatus
                    )
                }
            }
        }
        .onAppear {
            receiptAdminViewModel.observeOrderStatusChanges(receipt: receipt)
        }
    }
}


