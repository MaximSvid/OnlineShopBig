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
    
    // Fügt ein neues Produkt zur Datenbank hinzu
    func addNewProduct(product: Product) throws {
        do {
            try db.collection("products").addDocument(from: product)
        } catch {
            throw error
        }
    }
    
    // Beobachtet Änderungen an Produkten und gibt sie zurück
    func observeProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        db.collection("products").addSnapshotListener { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = querySnapshot?.documents else { return }
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
    
    // Entfernt ein Produkt aus der Datenbank
    func deleteProduct(productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
            db.collection("products").document(productId).delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    
    // Schaltet die Sichtbarkeit eines Produkts um
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
    
    // Aktualisiert ein bestehendes Produkt in der Datenbank
    func updateProduct(product: Product) throws {
            guard let productId = product.id else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid product ID"])
            }

            do {
                try db.collection("products").document(productId).setData(from: product, merge: true)
            } catch {
                throw error
            }
        }
}
