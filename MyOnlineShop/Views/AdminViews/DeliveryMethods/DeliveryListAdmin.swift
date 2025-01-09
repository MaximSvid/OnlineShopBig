//
//  DeliveryListAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI

struct DeliveryListAdmin: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    var delivery: Delivery
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Delivery Firm: \(delivery.deliveryName)")
                    .font(.headline)
                
                Text("Delivery Price: \(delivery.deliveryPrice)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Text("Delivery Time: \(delivery.deliveryTime)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)

            }
            Spacer()
            Divider()
            Button(action: {
                deliveryAdminViewModel.prepareForEdit(delivery)
                
            }) {
                Image(systemName: "pencil")
                    .font(.title)
                    .foregroundStyle(.green)
            }
            .buttonStyle(.plain)
        }
        .frame(width: .infinity, height: 80)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 3)
                .fill(.white)
                .shadow(radius: 3)
        )
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                deliveryAdminViewModel.deleteDelivery(delivery: delivery)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
//    DeliveryListAdmin()
}
