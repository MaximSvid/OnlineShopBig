//
//  ReceiptUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI

struct ReceiptUser: View {
    @EnvironmentObject var receiptUserViewModel: ReceiptUserViewModel
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(receiptUserViewModel.receipts) { receipt in
                        ForEach(receipt.product) { product in
                            ReceiptCartUser( product: product)
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("My Receipts")
                            .font(.title.bold())
                    }
                }
                .onAppear {
                    receiptUserViewModel.observeReceipt()
                }
            }
        }
    }
}

#Preview {
    ReceiptUser()
}
