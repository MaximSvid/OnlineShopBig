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
    
    // Speichert einen Beleg in der Datenbank
    func saveReceipt(_ receipt: Receipt) throws {
        let db = Firestore.firestore()
        try db.collection("users")
            .document(receipt.userId)
            .collection("receipts") // Erstellt die Sammlung "receipts"
            .document()
            .setData(from: receipt)
    }
    
    // Holt die Belegdaten eines Benutzers
    func fetchReceiptUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void) {
        let userRef = db.collection("users").document(userId)
        
        let cartRef = userRef.collection("cart")
        let userInfoRef = userRef.collection("userDeliveryInfo")
        let userDeliveryMethodRef = userRef.collection("deliveryMethods")
        let userPaymentMethodRef = userRef.collection("userPaymentMethod")
        
        Task {
            do {
                // Holt Benutzerinformationen
                let userInfoSnapshot = try await userInfoRef.getDocuments()
                guard let userInfoDoc = userInfoSnapshot.documents.first,
                      let userInfo = try? userInfoDoc.data(as: DeliveryUserInfo.self) else {
                    throw NSError(domain: "User info not found", code: -1)
                }
                
                // Holt Informationen aus dem Warenkorb
                let cartSnapshot = try await cartRef.getDocuments()
                let cartItems: [OrderedProduct] = cartSnapshot.documents.compactMap { document in
                    guard let product = try? document.data(as: Product.self) else { return nil }
                    
                    let quantity = product.purchasedQuantity > 0 ? product.purchasedQuantity : 1
                    return OrderedProduct(
                        id: document.documentID,
                        images: product.images,
                        title: product.title,
                        quantity: quantity,
                        pricePerUnit: product.price,
                        totalPrice: product.price * Double(quantity),
                        productId: product.id ?? ""
                    )
                }
                let totalProductPrice = cartItems.reduce(0) { $0 + $1.totalPrice }
                
                // Holt die Versandmethode
                let deliverySnapshot = try await userDeliveryMethodRef.getDocuments()
                guard let deliveryDoc = deliverySnapshot.documents.first,
                      let deliveryMethods = try? deliveryDoc.data(as: DeliveryMethod.self) else {
                    throw NSError(domain: "Delivery method not found", code: -1)
                }
                
                // Holt die Zahlungsmethode
                let paymentSnapshot = try await userPaymentMethodRef.getDocuments()
                guard let paymentDoc = paymentSnapshot.documents.first,
                      let paymentMethod = try? paymentDoc.data(as: PaymentMethod.self) else {
                    throw NSError(domain: "Payment method not found", code: -1)
                }
                
                let totalDeliveryPrice = deliveryMethods.deliveryPrice
                let finalTotalPrice = totalProductPrice + totalDeliveryPrice
                
                // Erstellt den Beleg
                let receipt = Receipt(
                    products: cartItems,
                    totalProductPrice: totalProductPrice,
                    totalDeliveryPrice: totalDeliveryPrice,
                    finalTotalPrice: finalTotalPrice,
                    userInfo: userInfo,
                    deliveryMethod: deliveryMethods,
                    paymentMethod: paymentMethod,
                    dateCreated: Date(),
                    userId: userId,
                    orderStatus: .new
                )
                completion(.success(receipt))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // Beobachtet die Belege eines Benutzers und gibt sie zurück
    func observeReceiptsUsers(userId: String, completion: @escaping (Result<[Receipt], any Error>) -> Void) {
        let userReceiptRef = db.collection("users").document(userId).collection("receipts")
        
        userReceiptRef.addSnapshotListener { QuerySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = QuerySnapshot?.documents else {
                completion(.success([]))
                return
            }
            let userReceipts = documents.compactMap { document -> Receipt? in
                try? document.data(as: Receipt.self)
            }
            completion(.success(userReceipts))
        }
    }
    
}
