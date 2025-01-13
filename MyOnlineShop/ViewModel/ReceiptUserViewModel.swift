//
//  ReceiptUserViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class ReceiptUserViewModel: ObservableObject {
    @Published var receipts: [Receipt] = []
    
    @Published var products: [Product] = []
    
    @Published var totalProductsPrice: Double = 0
    @Published var userInfo: DeliveryUserInfo
    @Published var deliveryMethod: DeliveryMethod
    @Published var paymentMethod: PaymentMethod
    
    @Published var totalPrice: Double = 0
    @Published var orderStatus: OrderSatatus = .new
    @Published var dateCreated: Date? = Date()
    
//    @Published var userId: String = ""
    
    
    private let fb = FirebaseService.shared
    
    private let receiptUserRepository: ReceiptUserRepository
    
    init(
        userInfo: DeliveryUserInfo,
        deliveryMethod: DeliveryMethod,
        paymentMethod: PaymentMethod,
        receiptUserRepository: ReceiptUserRepository = ReceiptUserRepositoryImplementation()
    ) {
        self.userInfo = userInfo
        self.deliveryMethod = deliveryMethod
        self.paymentMethod = paymentMethod
        self.receiptUserRepository = receiptUserRepository
    }
    
    func addNewReceipt() {
        let newReceipt = Receipt(
            products: products,
            totalProductPrice: totalProductsPrice,
            userInfo: userInfo,
            deliveryMethod: deliveryMethod,
            paymentMethod: paymentMethod,
            totalPrice: totalPrice,
            orderStatus: orderStatus
//            userId: userId
        )
        do {
            try receiptUserRepository.addNewCheck(receipt: newReceipt)
            print("Receipt added: \(newReceipt)")
        } catch {
            print("Error adding receipt: \(error)")
        }
    }
        
}
