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
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showError: Bool = false
    @State private var showAlert: Bool = false
    @State private var showFireworks: Bool = false
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(userCartViewModel.products) { product in
                            CartListCompletion(product: product)
                        }
                        
                        ShippinDetailsCompletion()
                        
                        PaymentUser()
                        
                        PriceOrderCompletion()
                        
                        
                        if showError {
                            Text("Please select a payment method")
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                        
                        Button(action: {
                            if paymentAdminViewModel.selectedPayment != nil {
                                handleOrderSubmission()
                                showFireworks = true
                                showAlert = true
                                showError = false
                            } else {
                                showError = true
                            }
                        }) {
                            Text("Buy Now")
                                .font(.headline.bold())
                                .frame(width: .infinity, height: 50)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.backgroundColor)
                                .background(Color.primaryBrown)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("🎉 Congratulations! 🎉"),
                                message: Text("Thank you for your order! We're already working on it. You can track your order progress in the order information section."),
                                dismissButton: .default(Text("Ok"), action: {
                                    selectedTab = 4
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        dismiss()
                                    }
                                    
                                })
                            )
                        }
                    }
                    .padding([.leading, .trailing])
                }
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
        if paymentAdminViewModel.selectedPayment != nil {
            deliveryAdminViewModel.isError = false
            deliveryAdminViewModel.errorMessage = nil
            deliveryUserInfoViewModel.addOrUpdateDeliveryUserInfo()
            deliveryAdminViewModel.addUserDeliveryMethod()
            paymentAdminViewModel.addUserPaymentMethod()
            userCartViewModel.updateCountGoods()
            
            deliveryAdminViewModel.selectedDelivery = nil
            paymentAdminViewModel.selectedPayment = nil
            deliveryAdminViewModel.errorMessage = nil
            couponUserViewModel.appliedCoupon = nil 
            
            
            Task {
                await receiptUserViewModel.fetchAndSaveReceipt()
                await paymentAdminViewModel.deletePaymentMethodFromUser()
                await deliveryAdminViewModel.deleteDeliveryFormUser()
                await userCartViewModel.removeAllFromCart()
            }
            
            deliveryAdminViewModel.isError = true
        }
    }
}
