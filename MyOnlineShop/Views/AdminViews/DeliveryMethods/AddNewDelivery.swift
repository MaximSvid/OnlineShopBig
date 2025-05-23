//
//  AddNewDelivery.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI

struct AddNewDelivery: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @State private var showError: Bool = false

    var body: some View {
        VStack {
            ContaiterRechtangle {
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Personal Details")
                            .foregroundStyle(.black.opacity(0.7))
                        Spacer()
                    }
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
                    
                    if showError {
                        Text("Please fill all fields")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    
                    
                    Button(action: {
                        if !deliveryAdminViewModel.deliveryName.isEmpty || !deliveryAdminViewModel.deliveryPrice.isZero || !deliveryAdminViewModel.deliveryTime.isEmpty {
                            deliveryAdminViewModel.addNewDelivery()
                        } else {
                            showError = true
                        }
                        
                    }) {
                        Text("Add")
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(Color.primaryBrown)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }
                .padding([.leading, .trailing])
            }

        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    AddNewDelivery()
        .environmentObject(DeliveryAdminViewModel())
}
