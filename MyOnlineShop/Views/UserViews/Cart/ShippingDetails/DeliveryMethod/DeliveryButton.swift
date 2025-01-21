//
//  DeliveryButton.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.01.25.
//

import SwiftUI

struct DeliveryButton: View {
    let delivery: DeliveryMethod
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                // Checkbox
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundStyle(isSelected ?  Color.primaryBrown : Color.secondaryGray)

                VStack(alignment: .leading, spacing: 4) {
                    Text(delivery.deliveryName)

                    Text(delivery.deliveryTime)
                        .font(.caption)
                        .foregroundStyle(Color.secondaryGray)
                }

                Spacer()

                Text("€\(String(format: "%.2f", delivery.deliveryPrice))")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(isSelected ? Color.primaryBrown.opacity(0.1) : Color.backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(isSelected ? Color.primaryBrown.opacity(0.1) : Color.secondaryGray, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
