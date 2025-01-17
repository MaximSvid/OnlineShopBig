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
            Picker("Status", selection: Binding(
                get: {
                    receipt.orderStatus
                },
                set: { newStatus in
                    onStatusChange(newStatus)
                }
            )) {
                ForEach(OrderStatus.allCases, id: \.self) { status in
                    Text(status.rawValue.capitalized)
                        .tag(status)
                }
            }
            .pickerStyle(.menu)
        }
        .foregroundStyle(receipt.orderStatus.color)
    }
}
               
               
               
