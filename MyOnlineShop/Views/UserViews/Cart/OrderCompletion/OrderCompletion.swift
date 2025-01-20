//
//  OrderCompletion.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.01.25.
//

import SwiftUI
import FirebaseAuth

struct OrderCompletion: View {
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    @EnvironmentObject var couponUserViewModel: CouponUserViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @EnvironmentObject var paymentAdminViewModel: PaymentAdminViewModel
    @EnvironmentObject var receiptUserViewModel: ReceiptUserViewModel
    
    @State private var showAlert: Bool = false
    @Binding var selectedTab: Int
    @State private var navigationToFireworks: Bool = false
    
    
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
//                            deliveryAdminViewModel.errorMessage = nil
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total price: ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        //эта цена должна сохранятся, как финальная цена заказа в базу данных
                        Text(String(format: "€ %.2f", deliveryAdminViewModel.selectedDeliveryPrice + couponUserViewModel.finalAmount))
                            .font(.headline)
                            .foregroundStyle(couponUserViewModel.appliedCoupon != nil ? .green : .primary)
                    }
                    
                    
                    Button(action: {
                        handleOrderSubmission()
                        showAlert = true
                    }) {
                        Text("Buy Now")
                            .font(.headline.bold())
                            .frame(width: .infinity, height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(.blue.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Order Received"),
                            message: Text("You can view your progress in the order information."),
                            dismissButton: .default(Text("OK"), action: {
                                selectedTab = 4
                            })
                        )
                    }
//                    NavigationLink (
//                        destination: ReceiptUser(),
//                        isActive: $navigateToReceiptUser
//                    ) {
//                        EmptyView()
//                    }
//                    .hidden()

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
    
    private func handleOrderSubmission() {
        if deliveryAdminViewModel.selectedDelivery != nil {
            deliveryAdminViewModel.isError = false
            deliveryAdminViewModel.errorMessage = nil
            deliveryUserInfoViewModel.addNewDeliveryUserInfo()
            deliveryAdminViewModel.addUserDeliveryMethod()
            paymentAdminViewModel.addUserPaymentMethod()
            userCartViewModel.updateCountGoods()
            
            deliveryAdminViewModel.selectedDelivery = nil
            paymentAdminViewModel.selectedPayment = nil
            deliveryAdminViewModel.errorMessage = nil
            
//            selectedTab = 4

            Task {
                await receiptUserViewModel.fetchAndSaveReceipt()
                await paymentAdminViewModel.deletePaymentMethodFromUser()
                await deliveryUserInfoViewModel.deleteDeliveryUserInfoFromUser()
                await deliveryAdminViewModel.deleteDeliveryFormUser()
                await userCartViewModel.removeAllFromCart()
            }
            
            deliveryAdminViewModel.isError = true
//            deliveryAdminViewModel.errorMessage = "Please select a delivery method"
        }
    }
}
