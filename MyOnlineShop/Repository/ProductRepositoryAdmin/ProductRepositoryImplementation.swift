//
//  ProductRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 18.12.24.
//
import SwiftUI
import Firebase

class ProductRepositoryImplementation: ProductRepositoryAdmin {
    private let db = Firestore.firestore()
    func addNewProduct(product: Product)  throws {
        do {
            try db.collection("products").addDocument(from: product)
        } catch {
            throw error
        }
    }
    
    
    func observeProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        db.collection("products").addSnapshotListener { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let products = documents.compactMap { document -> Product? in
                do {
                    return try document.data(as: Product.self)
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
            completion(.success(products))
        }
    }
    
    func deleteProduct(productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
            db.collection("products").document(productId).delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    func toggleVisibility(for productId: String, isVisible: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
            db.collection("products").document(productId).updateData([
                "isVisible": isVisible
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
}
