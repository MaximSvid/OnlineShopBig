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
    @Published var actionPrice: Double = 0.0
    @Published var description: String = ""
    @Published var brand: String = ""
    @Published var countProduct: Int = 0
    @Published var category: Categories = .livingRoom
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
    
    private let productRepository: ProductRepositoryAdmin
    
    init(productRepository: ProductRepositoryAdmin = ProductRepositoryImplementation()) {
        
        self.productRepository = productRepository //dependensy injection
        observeProducts()
    }
    
    func addNewProduct() {
        let newProduct = Product(
            title: title,
            price: price,
            actionPrice: actionPrice,
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
            try productRepository.addNewProduct(product: newProduct)
            print("Product added successfully: \(newProduct)")
        } catch {
            print("Error adding new product: \(error)")
        }
    }
    
    //ich möchte im realTime producte becommen aus Firebase
    
    func observeProducts() {
            productRepository.observeProducts { result in
                switch result {
                case .success(let products):
                        self.products = products
                        self.showAllProducts()
                case .failure(let error):
                    print("Error observing products: \(error.localizedDescription)")
                }
            }
        }
    
    func showAllProducts() {
        filteredProducts = products
        print("Showing all products. Ohne filter")
    }
    
    func deleteProduct(product: Product) {
        guard let productId = product.id else {
            productErrorMessage = "Product ID is missing"
            return
        }
    }
    
    //visibility bei admin
    func toggleVisibility(for product: Product) {
            guard let productId = product.id else {
                return
            }
            
            let newVisibility = !product.isVisible
            productRepository.toggleVisibility(for: productId, isVisible: newVisibility) { result in
                switch result {
                case .success:
                        if let index = self.products.firstIndex(where: { $0.id == productId }) {
                            self.products[index].isVisible = newVisibility
                        }
                    print("Visibility updated successfully")
                case .failure(let error):
                    print("Error updating visibility: \(error.localizedDescription)")
                }
            }
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
}
    

