//
//  OrderCompletion.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.01.25.
//

import SwiftUI

struct OrderCompletion: View {
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
                    
                    Button(action: {
                        //здесь должна быть логика сохранения иформации о пользователе, самом заказе, способе доставки и оплаты
                        //после успешного выполнения заказа необходимо сделать анимацию - заказ принят успешно и перевод на страницу с заказами
                        deliveryUserInfoViewModel.addNewDeliveryUserInfo()
                        deliveryAdminViewModel.addUserDeliveryMethod()
                        paymentAdminViewModel.addUserPaymentMethod()
                    }) {
                        Text("Buy Now")
                            .font(.headline.bold())
                            .frame(width: .infinity, height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(.blue.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Order Completion")
                    .font(.title.bold())
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
//    OrderCompletion()
//}
