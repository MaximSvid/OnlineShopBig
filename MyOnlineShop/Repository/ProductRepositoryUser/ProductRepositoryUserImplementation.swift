//
//  ProductRepositoryUserImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI
import Firebase

class ProductRepositoryUserImplementation: ProductRepositoryUser {
    
    private let db = Firestore.firestore()
    
    func observeProductsUser(completion: @escaping (Result<[Product], Error>) -> Void) {
        db.collection("products").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let products = documents.compactMap { document -> Product? in
                do {
                    return try document.data(as: Product.self)
                }catch {
                    print("Error decoding document: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(.success(products))
        }
    }
        
    func updatefavoriteStatus(product: Product, isFavorite: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let productId = product.id else {
            completion(.failure(NSError(domain: "No product id", code: -1)))
            return
        }
        db.collection("products").document(productId).updateData(["isFavorite": isFavorite]) { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
