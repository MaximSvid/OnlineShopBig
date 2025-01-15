//
//  ReceiptsAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//

import SwiftUI

struct ReceiptsAdmin: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    var body: some View {
        
        NavigationStack {
//            ScrollView {
                VStack {
                    List (receiptAdminViewModel.receipts) { receipt in
                        ReceiptListUser(receipt: receipt)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("My Receipts")
                            .font(.title.bold())
                    }
                }
                .onAppear {
                    Task {
                        await receiptAdminViewModel.fetchAllReceipts()
                    }
                
                }
            }
//        }
    }
}


#Preview {
//    ReceiptsAdmin()
}
