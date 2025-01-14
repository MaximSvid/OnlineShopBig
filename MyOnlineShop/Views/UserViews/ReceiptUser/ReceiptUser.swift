//
//  ReceiptUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI

struct ReceiptUser: View {
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
//                    ForEach() { receipt in
//                        ReceiptListUser()
//                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("My Receipts")
                            .font(.title.bold())
                    }
                }
            }
        }
    }
}

#Preview {
    ReceiptUser()
}
