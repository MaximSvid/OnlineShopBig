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
        
        do {
            let data = try Firestore.Encoder().encode(product)
            userCartRef.setData(data) { error in
                if let error {
                    completion(.failure(error))
                    return
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
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
    
    func updateCountProduct (userId: String, productId: String, productCount: Int, completion: @escaping (Result<Void, any Error>) -> Void) {
        
        let userCartRef = db.collection("users").document(userId).collection("cart").document(productId)
        
        userCartRef.updateData(["countProduct": productCount]) { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func removeFromCart(userId: String, productId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let userCartRef = db.collection("users").document(userId).collection("cart").document(productId)
        userCartRef.delete() { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func removeAllFromCart(userId: String) async throws {
        let cartRef = db.collection("users").document(userId).collection("cart")
        
        let snapshot = try await cartRef.getDocuments()
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
    
    func updateCountGoods(productId: String, countProduct: Int) throws {
        let countRef = db.collection("products").document(productId)
        
        countRef.updateData(["countProduct": countProduct])
    }
    
}
