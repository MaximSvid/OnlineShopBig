//
//  CheckUserRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI
import Firebase

class ReceiptUserRepositoryImplementation: ReceiptUserRepository {
    
    private let db = Firestore.firestore()
    
    func saveReceipt(_ receipt: Receipt) throws {
        let db = Firestore.firestore()
        try db.collection("users")
            .document(receipt.userId)
            .collection("receipts") // создаст коллекцию receipts
            .document()
            .setData(from: receipt)
    }
    
    func fetchReceiptUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void) {
        
            
        let userRef = db.collection("users").document(userId)
        
        let cartRef = userRef.collection("cart")
        let userInfoRef = userRef.collection("userDeliveryInfo")
        let userDeliveryMethodRef = userRef.collection("deliveryMethods")
        let userPaymentMethodRef = userRef.collection("userPaymentMethod")
        
        Task {
            do {
                //получаем информацию о пользователе
                let userInfoSnapshot = try await userInfoRef.getDocuments()
                guard let userInfoDoc = userInfoSnapshot.documents.first,
                      let userInfo = try? userInfoDoc.data(as: DeliveryUserInfo.self) else {
                    throw NSError(domain: "User info not found", code: -1)
                }
                
                //получаем информацию из корзины
                let cartSnapshot = try await cartRef.getDocuments()
                let cartItems = cartSnapshot.documents.compactMap { try? $0.data(as: Product.self)}
                let totalProductPrice = cartItems.reduce(0) { $0 + ($1.price) }
                
                // получаем метод доставки
                let deliverySnapshot = try await userDeliveryMethodRef.getDocuments()
                guard let deliveryDoc = deliverySnapshot.documents.first,
                      let deliveryMethods = try? deliveryDoc.data(as: DeliveryMethod.self) else {
                    throw NSError(domain: "Delivery method not found", code: -1)
                }
                
                //получаем метод оплаты
                let paymentSnapshot = try await userPaymentMethodRef.getDocuments()
                guard let paymentDoc = paymentSnapshot.documents.first,
                      let paymentMethod = try? paymentDoc.data(as: PaymentMethod.self) else {
                    throw NSError(domain: "Payment method not found", code: -1)
                }
                
                let totalPrice = totalProductPrice + deliveryMethods.deliveryPrice
                
                let receipt = Receipt(
                    products: cartItems,
                    totalProductPrice: totalProductPrice,
                    userInfo: userInfo,
                    deliveryMethod: deliveryMethods,
                    paymentMethod: paymentMethod,
                    totalPrice: totalPrice,
                    orderStatus: .new,
                    dateCreated: Date(),
                    userId: userId
                )
                completion(.success(receipt))
            } catch {
                completion(.failure(error))
            }
        }
        
    }
}
