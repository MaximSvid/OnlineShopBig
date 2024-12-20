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
                self.loadFavorites()
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
            guard let userID = FirebaseService.shared.userId,
                  let productID = product.id,
                  let index = products.firstIndex(where: { $0.id == productID }) else { return }
        
        products[index].isFavorite.toggle()

            productRepositoryUser.updateFavoriteStatus(
                userID: userID,
                productID: productID,
                product: product,
                isFavorite: products[index].isFavorite
            ) { result in
                switch result {
                case .success:
                    print("Favorite status successfully updated for product \(productID)")
                    self.loadFavorites()
                case .failure(let error):
                    print("Failed to update favorite status: \(error.localizedDescription)")
                    // В случае ошибки возвращаем статус на исходный
                    self.products[index].isFavorite.toggle()
                }
            }
        }
    
    func loadFavorites() {
        guard let userID = FirebaseService.shared.userId else { return }
        
        productRepositoryUser.loadFavoriteProducts(userID: userID) { result in
            switch result {
            case .success(let favorites):
                    self.favoriteProducts = favorites  
            case .failure(let error):
                print("Error loading favorite products: \(error.localizedDescription)")
            }
        }
    }
}
