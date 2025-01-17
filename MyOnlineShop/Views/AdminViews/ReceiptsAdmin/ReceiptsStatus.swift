//
//  ReceiptsStatus.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.01.25.
//

import SwiftUI

struct ReceiptsStatus: View {
    var receipt: Receipt
    let onStatusChange: (OrderStatus) -> Void
    
    var body: some View {
        VStack {
            Picker(selection: Binding(
                get: {
                    receipt.orderStatus
                },
                set: { newStatus in
                    if newStatus != receipt.orderStatus {
                        onStatusChange(newStatus)
                    }
                }
            )) {
                ForEach(OrderStatus.allCases, id: \.self) { status in
                    Text(status.rawValue.capitalized)
                        .tag(status)
                }
            } label: {
                Text(receipt.orderStatus.rawValue.capitalized)
                                .padding(8)
                                .background(receipt.orderStatus.color)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .foregroundColor(.white)            }
            .pickerStyle(.menu)
        }
        
    }
}
               
               
               
