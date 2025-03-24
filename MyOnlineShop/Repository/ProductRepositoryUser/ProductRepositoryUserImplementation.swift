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
    
    // Beobachtet Produkte für Benutzer und gibt sie zurück
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
    
    // Aktualisiert den Favoritenstatus eines Produkts für einen Benutzer
    func updateFavoriteStatus(userID: String, productID: String, product: Product, isFavorite: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        let userFavoritesRef = db.collection("users").document(userID).collection("favorites").document(productID)
        
        if isFavorite {
            do {
                var updatedProduct = product
                updatedProduct.isFavorite = true
                
                try userFavoritesRef.setData(from: updatedProduct) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        } else {
            userFavoritesRef.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    // Lädt die Favoritenprodukte eines Benutzers
    func loadFavoriteProducts(userID: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let favoritesRef = db.collection("users").document(userID).collection("favorites")
        
        favoritesRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let products = documents.compactMap { doc -> Product? in
                try? doc.data(as: Product.self)
            }
            
            completion(.success(products))
        }
    }
}
