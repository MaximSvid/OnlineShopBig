//
//  DeliveryMethodSelector.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct DeliveryMethodSelector: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
        @State private var selectedDeliveryId: String?
        @FocusState private var isFocused: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(deliveryAdminViewModel.deliveries) { delivery in
                    HStack {
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
                        
                        if selectedDeliveryId == delivery.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .padding(.leading, 8)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(selectedDeliveryId == delivery.id ? .black : .gray.opacity(0.8), lineWidth: 1)
                    )
                    .onTapGesture {
                        selectedDeliveryId = delivery.id
                        isFocused = true
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear {
                print("DeliveryMethodSelector appeared")
                deliveryAdminViewModel.observeDeliveries()
            }
        }
}
    
    #Preview {
        //    DeliveryMethodSelector()
    }
