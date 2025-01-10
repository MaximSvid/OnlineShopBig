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
                   Button(action: {
                       selectedDeliveryId = delivery.id
                       isFocused = true
                   }) {
                       HStack {
                           // Checkbox
                           Image(systemName: selectedDeliveryId == delivery.id ? "checkmark.square.fill" : "square")
                               .foregroundColor(selectedDeliveryId == delivery.id ? .green : .gray)
                               
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
                               .fill(selectedDeliveryId == delivery.id ? Color.green.opacity(0.1) : Color.white)
                       )
                       .overlay(
                           RoundedRectangle(cornerRadius: 3)
                               .stroke(selectedDeliveryId == delivery.id ? .green : .gray.opacity(0.8), lineWidth: 1)
                       )
                   }
                   .buttonStyle(PlainButtonStyle())
               }
               .listStyle(PlainListStyle())
           }
           .onAppear {
               deliveryAdminViewModel.observeDeliveries()
           }
       }
   }

//#Preview {
//    //    DeliveryMethodSelector()
//}
