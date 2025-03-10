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
    
    @Environment(\.dismiss) private var dismiss // для закрытия представления orderCompletion
    
    @State private var showError: Bool = false
    @State private var showAlert: Bool = false
    @State private var showFireworks: Bool = false
    @State private var bursts: [FireworkBurst] = []
    
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
    //данную функцию нет необходимости хранить в репозитории так как это UI логика
    private func startFireworks() {
        var timerCount = 0 // Счетчик времени (нужно для того чтобы анимация продолжалась только 5 секунд а затем переставала иначе, если сразу сделать заказ анимация не даст соверишить заказ...
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if showFireworks {
                let newBurst = FireworkBurst()
                bursts.append(newBurst)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    bursts.removeAll(where: { $0.id == newBurst.id })
                }
                timerCount += 1
                if timerCount >= 10 { // 10 итераций = 5 секунд
                    showFireworks = false
                    timer.invalidate()
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
            
//            if deliveryAdminViewModel.exist {
//                deliveryUserInfoViewModel.addNewDeliveryUserInfo()
//            } else {
//                deliveryAdminViewModel.updateDelivery()
//            }
            
//            deliveryUserInfoViewModel.addNewDeliveryUserInfo()
            deliveryUserInfoViewModel.addOrUpdateDeliveryUserInfo()// обновить или создать информацию о пользователе
            deliveryAdminViewModel.addUserDeliveryMethod()
            paymentAdminViewModel.addUserPaymentMethod()
            userCartViewModel.updateCountGoods()
            
            deliveryAdminViewModel.selectedDelivery = nil
            paymentAdminViewModel.selectedPayment = nil
            deliveryAdminViewModel.errorMessage = nil
            couponUserViewModel.appliedCoupon = nil //обнуляю использование купона
            
            
            Task {
                await receiptUserViewModel.fetchAndSaveReceipt()
                await paymentAdminViewModel.deletePaymentMethodFromUser()
//                await deliveryUserInfoViewModel.deleteDeliveryUserInfoFromUser() удалять информацию о пользователе нет особого смысла. проще ее сохранять и затем отображать 
                await deliveryAdminViewModel.deleteDeliveryFormUser()
                await userCartViewModel.removeAllFromCart()
            }
            
            deliveryAdminViewModel.isError = true
        }
    }
}
