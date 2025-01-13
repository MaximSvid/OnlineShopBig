//
//  UserProductViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI
import Firebase
import Combine

@MainActor
class UserProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var favoriteProducts: [Product] = []
    
    @Published var searchText: String = ""
    @Published var isSearchVisible: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let productRepositoryUser: ProductRepositoryUser

    init(productRepositoryUser: ProductRepositoryUser = ProductRepositoryUserImplementation()) {
        self.productRepositoryUser = productRepositoryUser
        // Наблюдаем за изменениями searchText
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchProducts(searchText: searchText)
            }
            .store(in: &cancellables)
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
        // Локальное обновление статуса
        products[index].isFavorite.toggle()
        
        // Сразу обновляем UI для избранного
            if products[index].isFavorite {
                favoriteProducts.append(products[index])
            } else {
                favoriteProducts.removeAll { $0.id == productID }
            }

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
    
    func searchProducts(searchText: String) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter {product in
                product.title.localizedCaseInsensitiveContains(searchText) || //Проверяет, содержит ли название продукта (title) текст из поля поиска.
                product.description.localizedCaseInsensitiveContains(searchText) || //Проверяет, содержит ли название продукта (description) текст из поля поиска.
                product.category.localizedCaseInsensitiveContains(searchText) || //Проверяет, содержит ли название продукта (category) текст из поля поиска.
                product.brand.localizedCaseInsensitiveContains(searchText) //Проверяет, содержит ли название продукта (brand) текст из поля поиска.
            }
        }
    }
}
