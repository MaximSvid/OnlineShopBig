//
//  AddNewDelivery.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI

struct AddNewDelivery: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @State private var toast: Toast? = nil

    var body: some View {
        VStack {
            ContaiterRechtangle {
                CustomTextField(placeholder: "Delivery name", text: $deliveryAdminViewModel.deliveryName)
                
                CustomTextField(
                    placeholder: "Delivery price",
                    text: Binding(
                        get: { String(format: "%.2f", deliveryAdminViewModel.deliveryPrice) },
                        set: { newValue in
                            if let price = Double(newValue) {
                                deliveryAdminViewModel.deliveryPrice = price
                            }
                        }
                    )
                )
                CustomTextField(placeholder: "Delivery description", text: $deliveryAdminViewModel.deliveryTime)
                
                
                Button(action: {
                    if !deliveryAdminViewModel.deliveryName.isEmpty || !deliveryAdminViewModel.deliveryPrice.isZero || !deliveryAdminViewModel.deliveryTime.isEmpty {
                        deliveryAdminViewModel.addNewDelivery()
                    } else {
                        toast = Toast(style: .error, message: "Please fill all fields")
                    }
                    
                }) {
                    Text("Add")
                        .font(.headline.bold())
                        .frame(width: .infinity, height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                Spacer()
            }
            .onAppear {
                deliveryAdminViewModel.observeDeliveries()
            }
            .padding([.leading, .trailing])
            .toastView(toast: $toast)
            
        }
    }
}

#Preview {
    AddNewDelivery()
}
