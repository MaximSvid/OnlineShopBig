//
//  ReceiptListUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI

struct ReceiptListUser: View {
    
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    @EnvironmentObject var couponUserViewModel: CouponUserViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @EnvironmentObject var paymentAdminViewModel: PaymentAdminViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(userCartViewModel.products) { product in
                        CartListCompletion(product: product)
                    }
                    
                    ShippinDetailsCompletion()
                    
                    PaymentUser()
                    
                    HStack {
                        Text("Price: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        
                        Text(String(format: "€ %.2f", couponUserViewModel.finalAmount))
                            .font(.subheadline)
                    }
                    .padding(.top)

                    HStack {
                        Text("Delivery price: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        //здесь не видно вибраную доставку
                        if let selectedDelivery = deliveryAdminViewModel.selectedDelivery {
                            Text(String(format: "€ %.2f", selectedDelivery.deliveryPrice))
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        } else {
                            Text("Select delivery method")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total price: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        
                        Text(String(format: "€ %.2f", deliveryAdminViewModel.selectedDeliveryPrice + couponUserViewModel.finalAmount))
                            .font(.headline)
                            .foregroundStyle(couponUserViewModel.appliedCoupon != nil ? .green : .primary)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Receipt")
                            .font(.title.bold())
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .onAppear {
            userCartViewModel.loadCart()
            couponUserViewModel.updateFinalAmount(totalSum: userCartViewModel.totalSum)
            deliveryAdminViewModel.observeDeliveries()
        }
    }
}

//#Preview {
//    ReceiptListUser()
//}
