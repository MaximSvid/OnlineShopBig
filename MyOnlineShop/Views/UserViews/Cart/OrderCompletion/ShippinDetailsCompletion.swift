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
    @Environment(\.dismiss) private var dismiss // закрыть текущий экран
    
    var body: some View {
        ContaiterRechtangle {
            VStack {
                VStack(spacing: 15) {
                    HStack {
                        Text("Order Summary")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "pencil")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.brown)
                                        .shadow(radius: 3)
                                )
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text ("Full Name: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.firstName) \(deliveryUserInfoViewModel.lastName)")
                            .font(.body)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text ("Email: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.email)")
                            .font(.body)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text ("Phone: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.phoneNumber)")
                            .font(.body)
                        
                        Spacer()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing:  10) {
                    HStack {
                        Text ("Country: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.country)")
                            .font(.body)
                        
                        Spacer()
                    }
                    HStack {
                        Text ("Index: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.index)")
                            .font(.body)
                        
                        Spacer()
                    }
                    HStack {
                        Text ("City: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.city)")
                            .font(.body)
                        
                        Spacer()
                    }
                    HStack {
                        Text ("Street: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.street)")
                            .font(.body)
                        
                        Spacer()
                    }
                    HStack {
                        Text ("House Number: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Text("\(deliveryUserInfoViewModel.houseNumber)")
                            .font(.body)
                        
                        Spacer()
                    }
                    if !deliveryUserInfoViewModel.apartmentNumber.isEmpty {
                        HStack {
                            Text ("Apartment Number: ")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Text("\(deliveryUserInfoViewModel.apartmentNumber)")
                                .font(.body)
                            
                            Spacer()
                        }
                    }
                }
                
                Divider()
                                
                if let selectedDelivery = deliveryAdminViewModel.selectedDelivery {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Delivery Method")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                        
                        HStack {
                            Text ("Type: ")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Text("\(selectedDelivery.deliveryName)")
                                .font(.body)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text ("Time: ")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Text("\(selectedDelivery.deliveryTime)")
                                .font(.body)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text ("Price: ")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Text(String(format: "%.2f", selectedDelivery.deliveryPrice))
                                .font(.body)
                            
                            Spacer()
                        }

                    }
                }
                
                
            }
            .padding([.leading, .trailing])
        }
    }
}


