//
//  AdminReceipt.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.01.25.
//

import SwiftUI

struct AdminReceipts: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(receiptAdminViewModel.receipts) { receipt in
                    AdminReceiptsList(receipt: receipt)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("User Receipts")
                        .font(.title.bold())
                }
            }
            .onAppear {
                Task {
                    await receiptAdminViewModel.fetchAllReceipts()
                    
                }
            }
        }
        
    }
}


