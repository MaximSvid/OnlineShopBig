//
//  Untitled.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI
import Firebase

class CartRepositoryUserImplementation: CartRepositoryUser {
    private let db = Firestore.firestore()

    
    //?   nich sicher über diese func
    func getToCart(userId: String, productId: String, product: Product, completion: @escaping (Result<Void, any Error>) -> Void) {
        let userCartRef = db.collection("users").document(userId).collection("cart").document(productId)
        
        userCartRef.setData([
            "product": product
        ]) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func loadCartProducts(userId: String, completion: @escaping (Result<[Product], any Error>) -> Void) {
        let cartRef = db.collection("users").document(userId).collection("cart")
        
        cartRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([])) // пустой массив, если нет избранных товаров
                return
            }
            let products = documents.compactMap {doc -> Product? in
                try? doc.data(as: Product.self)
            }
            completion(.success(products))
        }
    }
    
}
