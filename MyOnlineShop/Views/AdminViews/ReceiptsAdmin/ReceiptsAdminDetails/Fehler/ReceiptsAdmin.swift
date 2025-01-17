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
            VStack {
                List (receiptAdminViewModel.receipts.sorted { $0.dateCreated > $1.dateCreated }) { receipt in
                    NavigationLink {
                        ReceiptListCardDetailAdmin(receipt: receipt)
                    } label: {
                        ReseiptsListAdmin(receipt: receipt)
                    }
                    
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


#Preview {
    //    ReceiptsAdmin()
}
