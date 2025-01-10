//
//  DeliveryMethodSelector.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct DeliveryMethodSelector: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(deliveryAdminViewModel.deliveries) { delivery in
                DeliveryButton(
                    delivery: delivery,
                    isSelected: deliveryAdminViewModel.selectedDelivery?.id == delivery.id
                ) {
                    deliveryAdminViewModel.selectedDelivery = delivery
                    isFocused = true
                }
            }
        }
        .onAppear {
            deliveryAdminViewModel.observeDeliveries()
        }
    }
}


struct DeliveryButton: View {
    let delivery: DeliveryMethod
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                // Checkbox
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .green : .gray)

                VStack(alignment: .leading, spacing: 4) {
                    Text(delivery.deliveryName)
                        .foregroundColor(.black)

                    Text(delivery.deliveryTime)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Text("€\(String(format: "%.2f", delivery.deliveryPrice))")
                    .foregroundColor(.black)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(isSelected ? Color.green.opacity(0.1) : Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(isSelected ? .green : .gray.opacity(0.8), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//#Preview {
//    //    DeliveryMethodSelector()
//}
