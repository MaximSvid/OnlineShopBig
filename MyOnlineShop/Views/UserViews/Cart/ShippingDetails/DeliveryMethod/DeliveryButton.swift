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
                    .foregroundStyle(isSelected ? .green : .gray)

                VStack(alignment: .leading, spacing: 4) {
                    Text(delivery.deliveryName)
                        .foregroundStyle(.black)

                    Text(delivery.deliveryTime)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                Spacer()

                Text("€\(String(format: "%.2f", delivery.deliveryPrice))")
                    .foregroundStyle(.black)
            }
            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 3)
//                    .fill(isSelected ? Color.green.opacity(0.1) : Color.white)
//            )
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(isSelected ? .green : .gray.opacity(0.8), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
