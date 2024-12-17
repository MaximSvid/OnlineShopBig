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
    @Published var isAddSheetOpen: Bool = false
    
    @Published var products: [Product] = []
    
    @Published var title: String = ""
    @Published var price: Double = 0.0
    @Published var description: String = ""
    @Published var brand: String = ""
    @Published var countProduct: Int = 0
    @Published var category: Categories = .allProducts
    @Published var image: String = ""
    @Published var rating: Double = 0.0
    @Published var isVisible: Bool = true
    @Published var selectedColor: ColorEnum = .blue
    @Published var isFavorite: Bool = false
    @Published var action: Bool = false
    
    @Published var productErrorMessage: String = ""
    
    @Published var selectedCategory: Categories? = nil
    @Published var filteredProducts: [Product] = []
    
    private let fb = FirebaseService.shared
    
    init() {
        observeProducts()
    }
    
    func addNewProduct() {
        let newProduct = Product(
            title: title,
            price: price,
            description: description,
            brand: brand,
            countProduct: countProduct,
            category: category.rawValue,
            image: image,
            rating: rating,
            isVisible: isVisible,
            selectedColor: selectedColor.rawValue,
            isFavorite: isFavorite,
            action: action
        )
        
        do {
            try
            fb.database.collection("products").addDocument(from: newProduct)
        } catch {
            print("Error adding new product: \(error)")
        }
    }
    
    //ich möchte im realTime producte becommen aus Firebase
    
    func observeProducts() {
        fb.database.collection("products").addSnapshotListener { querySnapshot, error in
            if let error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.products = documents.compactMap { document -> Product? in
                
                do {
                    let product = try document.data(as: Product.self)
                    print("Loaded product: \(product)")
                    return product
                    
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
            print("Products loaded: \(self.products.count)")
            self.showAllProducts()// am Anfang zeigen wir alle waren
        }
    }
    
    func deleteProduct(product: Product) {
        guard let productId = product.id else { return }
        
        fb.database.collection("products").document(productId).delete() { error in
            if let error {
                print("Error deleting product: \(error.localizedDescription)")
                return
            }
            print("Product deleted")
        }
    }
    
    //visibility bei admin
    func toggleVisibility (for product: Product) {
        guard let productId = product.id else { return }
        
        fb.database.collection("products").document(productId).updateData([
            "isVisible": !product.isVisible
        ]) { error in
            if error != nil {
                print("Error updating visibility: \(String(describing: error))")
            } else {
                print("Visibility updated")
            }
        }
    }
    
    func showAllProducts() {
        filteredProducts = products
        print("Showing all products. Ohne filter")
    }
    
    func filterProducts(by category: Categories) {
        switch category {
        case .allProducts:
            // Показать все продукты
            showAllProducts()
        case .action:
            // Фильтрация по признаку action
            filteredProducts = products.filter { $0.action }
            print("Filtered products where action is true: \(filteredProducts.count)")
        default:
            // Фильтрация по категории
            filteredProducts = products.filter { $0.category == category.rawValue }
            print("Filtered products by category: \(category.rawValue)")
        }
    }
    
//    func filterProducts(by category: Categories) {
//        if category == .allProducts {
//            showAllProducts()
//        } else {
//            filteredProducts = products.filter { $0.category == category.rawValue }
//            print("Filtered products by category: \(category.rawValue)")
//        }
//    }
//    
//    func filterByAction () {
//        filteredProducts = products.filter {$0.action}
//        print("Filtered products where action is true: \(filteredProducts.count)")
//    }
    
    
}
    

