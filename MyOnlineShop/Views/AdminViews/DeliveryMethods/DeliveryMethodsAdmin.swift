//
//  DeliveryMethodsAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI

struct DeliveryMethodsAdmin: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    var body: some View {
        NavigationStack {
            VStack {
                List(deliveryAdminViewModel.deliveries) { delivery in
                    DeliveryListAdmin(delivery: delivery)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain  )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Delivery Methods")
                        .font(.title.bold())
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        deliveryAdminViewModel.sheetAddDelivery.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(3)
                            .background(
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.primaryBrown)
                            )
                        
                    }
                }
            }
            .onAppear {
                deliveryAdminViewModel.observeDeliveries()
            }
            .sheet(isPresented: $deliveryAdminViewModel.sheetAddDelivery) {
                AddNewDelivery()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.8)])
            }
            .sheet(isPresented: $deliveryAdminViewModel.sheetEditDelivery) {
                EditDelivery()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.8)])
            }
        }
    }
}

