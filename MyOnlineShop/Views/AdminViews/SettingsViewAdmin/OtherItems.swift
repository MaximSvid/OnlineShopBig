//
//  SettingsView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct OtherItems: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: CouponsAdmin()) {
                        HStack {
                            Image(systemName: "tag")
                                .font(.subheadline)
                            
                            Text("New coupons and discounts")
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                } header: {
                    Text("Coupons")
                }
                
                Section {
                    NavigationLink (destination: DeliveryMethodsAdmin()) {
                        HStack {
                            Image(systemName: "truck.box.badge.clock")
                                .font(.subheadline)
                            
                            Text("New delivery methods")
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                } header: {
                    Text("Delivery settings")
                }
                
                Section {
                    NavigationLink (destination: PaymentAdmin()) {
                        HStack {
                            Image(systemName:  "dollarsign.bank.building")
                                .font(.subheadline)
                            
                            Text("Payment methods")
                                .font(.subheadline)
                            
                            Spacer()
                        }
                    }
                } header: {
                    Text("Payment methods")
                }
                
                Section {
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            
                            Text("Logout")
                            
                            Spacer()
                        }
                        .foregroundStyle(.red)
                        
                    }
                    
                } header: {
                    Text("Logout")
                }
                
                
            }.navigationTitle(Text("Other Items"))
        }
    }
}

