//
//  ProductViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class ProductViewModel: ObservableObject {
    @Published var addSheet: Bool = false
    
    @Published var products: [Product] = []
    
    @Published var title: String = ""
    @Published var price: Double = 0.0
    @Published var description: String = ""
    @Published var brand: String = ""
    @Published var countProduct: Int = 0
    @Published var category: String = ""
    @Published var image: String = ""
    @Published var rating: Double = 0.0
    @Published var isVisible: Bool = false
    @Published var selectedColor: ColorEnum = .black
//    @Published var selectedColor: String = ""
    
    private let fb = FirebaseService.shared
    
    func addNewProduct() {
        let newProduct = Product(
            title: title,
            price: price,
            description: description,
            brand: brand,
            countProduct: countProduct,
            category: category,
            image: image,
            rating: rating,
            isVisible: isVisible,
            selectedColor: selectedColor.rawValue
        )
        
        do {
            try
            fb.database.collection("products").addDocument(from: newProduct)
        } catch {
            print("Error adding new product: \(error)")
        }
    }
    
    //ich möchte im realTime producte becommen aud Firebase
    
    func listenToSnippets() {
        fb.database.collection("products").addSnapshotListener { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.products = documents.compactMap { document -> Product? in
                
                do {
                    return try document.data(as: Product.self)
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
        }
    }
    
//    func listenToSnippets() {
//        fb.database.collection( "products").addSnapshotListener { querySnapshot, error in
//            if let error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            let products = documents.compactMap { snapShot in
//                return try? snapShot.data(as: Product.self)
//            }
//        }
//    }
    
    
    
    
    
}
