//
//  StatusAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.01.25.
//

import SwiftUI

struct StatusAdmin: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(receiptAdminViewModel.receipts) { receipt in
                    OrderRow(
                        receipt: receipt,
                        onStatusChange: { newStatus in
                            Task {
                                await receiptAdminViewModel.updateOrderStatus(
                                    for: receipt,
                                    newStatus: newStatus
                                )
                            }
                        }
                    )
                }
            }
        }
    }
}

struct OrderStatusPicker: View {
    let receipt: Receipt
    let onStatusChange: (OrderSatatus) -> Void
    
    var body: some View {
        Picker("Status", selection: Binding(
            get: { receipt.orderStatus },
            set: { newStatus in onStatusChange(newStatus) }
        )) {
            ForEach(OrderSatatus.allCases, id: \.self) { status in
                Text(status.rawValue)
                    .tag(status)
            }
        }
        .pickerStyle(.menu)
        .tint(receipt.orderStatus.color)
    }
}

struct OrderRow: View {
    let receipt: Receipt
    let onStatusChange: (OrderSatatus) -> Void
    
    var body: some View {
        HStack {
            OrderStatusPicker(
                receipt: receipt,
                onStatusChange: onStatusChange
            )
            Spacer()
        }
    }
}

