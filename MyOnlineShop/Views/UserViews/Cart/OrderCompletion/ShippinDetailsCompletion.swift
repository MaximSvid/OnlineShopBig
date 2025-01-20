//
//  ShippinDetailsCompletion.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.01.25.
//

import SwiftUI

struct ShippinDetailsCompletion: View {
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    
    var body: some View {
        ContaiterRechtangle {
            VStack {
                VStack(spacing: 15) {
                    HStack {
                        Text("Order Summary")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    VStack {
                        CustomInfoRow(title: "Full Name", value: "\(deliveryUserInfoViewModel.firstName) \(deliveryUserInfoViewModel.lastName)")
                        CustomInfoRow(title: "Email", value: deliveryUserInfoViewModel.email)
                        CustomInfoRow(title: "Phone", value: deliveryUserInfoViewModel.phoneNumber)
                        
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing:  10) {
                    CustomInfoRow(title: "Country", value: deliveryUserInfoViewModel.country)
                    CustomInfoRow(title: "Index", value: deliveryUserInfoViewModel.index)
                    CustomInfoRow(title: "City", value: deliveryUserInfoViewModel.city)
                    CustomInfoRow(title: "Street", value: deliveryUserInfoViewModel.street)
                    CustomInfoRow(title: "House Number", value: deliveryUserInfoViewModel.houseNumber)
                    
                    if !deliveryUserInfoViewModel.apartmentNumber.isEmpty {
                        CustomInfoRow(title: "Apartment Number", value: deliveryUserInfoViewModel.apartmentNumber)
                    }
                }
                
                Divider()
                
                if let selectedDelivery = deliveryAdminViewModel.selectedDelivery {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Delivery Method")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        
                        CustomInfoRow(title: "Type", value: selectedDelivery.deliveryName)
                        CustomInfoRow(title: "Time", value: selectedDelivery.deliveryTime)
                        CustomInfoRow(title: "Price", value: String(format: "%.2f", selectedDelivery.deliveryPrice))
                        Spacer()
                    }
                    
                }
            }
            .padding([.leading, .trailing])
            
            
        }
    }
}



