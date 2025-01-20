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
    @Environment(\.dismiss) private var dismiss // для закрытия представления orderCompletion
    @State private var showFireworks: Bool = false
    @State private var bursts: [FireworkBurst] = []
    
    //    @State private var navigationToFireworks: Bool = false
    
    
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
                            if paymentAdminViewModel.selectedPayment != nil {
                                handleOrderSubmission()
                                showFireworks = true
                                showAlert = true
                            } else {
                                Text("Please select a payment method")
                                    .foregroundStyle(.red)
                            }
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
                                    //задержка в пол секудны, без нее происходят проблемы с navigationTab
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        dismiss() // закрываем представление
                                    }
                                    
                                })
                            )
                        }
                    }
                    .padding([.leading, .trailing])
                }
                .blur(radius: showFireworks ? 4 : 0) // добавляем размытие при показе фейерверков
                
                if showFireworks {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        
                        ForEach(bursts) { burst in
                            FireworkBurstView(burst: burst)
                        }
                    }
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
        .onChange(of: showFireworks) { newValue in
            if newValue {
                startFireworks()
            } else {
                bursts.removeAll()
            }
        }
    }
    
    private func startFireworks() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if showFireworks {
                let newBurst = FireworkBurst()
                bursts.append(newBurst)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    bursts.removeAll(where: { $0.id == newBurst.id })
                }
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func handleOrderSubmission() {
        if paymentAdminViewModel.selectedPayment != nil {
            deliveryAdminViewModel.isError = false
            deliveryAdminViewModel.errorMessage = nil
            deliveryUserInfoViewModel.addNewDeliveryUserInfo()
            deliveryAdminViewModel.addUserDeliveryMethod()
            paymentAdminViewModel.addUserPaymentMethod()
            userCartViewModel.updateCountGoods()
            
            deliveryAdminViewModel.selectedDelivery = nil
            paymentAdminViewModel.selectedPayment = nil
            deliveryAdminViewModel.errorMessage = nil
            
            Task {
                await receiptUserViewModel.fetchAndSaveReceipt()
                await paymentAdminViewModel.deletePaymentMethodFromUser()
                await deliveryUserInfoViewModel.deleteDeliveryUserInfoFromUser()
                await deliveryAdminViewModel.deleteDeliveryFormUser()
                await userCartViewModel.removeAllFromCart()
            }
            
            deliveryAdminViewModel.isError = true
        }
    }
}
