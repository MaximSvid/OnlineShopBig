//
//  UserProductViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI
import Firebase

@MainActor
class UserProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var favoriteProducts: [Product] = []
//    @Published var isLiked: Bool = false
    
    private let productRepositoryUser: ProductRepositoryUser
    
    init(productRepositoryUser: ProductRepositoryUser = ProductRepositoryUserImplementation()) {
        self.productRepositoryUser = productRepositoryUser
        
    }
    
    func observeUserProducts() {
        productRepositoryUser.observeProductsUser {result in
            switch result {
            case .success(let products):
                self.products = products
                self.showAllProducts()
            case .failure(let error):
                print(error)
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
    
    func toggleFavorite(for product: Product) {
        guard let index = products.firstIndex(where: { $0.id == product.id }) else { return }
            
            let newFavoriteStatus = !products[index].isFavorite
            products[index].isFavorite = newFavoriteStatus
        
        productRepositoryUser.updatefavoriteStatus(product: product, isFavorite: newFavoriteStatus) { result in
            switch result {
            case .success:
                print("Updated favorite status")
                self.updateFavoriteList()
            case .failure:
                print("Error updating favorite status")
            }
        }
    }
    
    func updateFavoriteList() {
        favoriteProducts = products.filter{ $0.isFavorite }
    }

}
