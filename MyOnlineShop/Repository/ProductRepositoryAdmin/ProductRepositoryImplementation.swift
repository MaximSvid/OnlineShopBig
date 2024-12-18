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
    
    
    func observeProducts() {
        
    }
    
    func deleteProduct(product: Product) {
        
    }
    
    func toggleVisibility(for product: Product) {
        
    }
    
    func showAllProducts() {
        
    }
    
    
}
