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

    // Initialisiert das ViewModel mit einem ProductRepositoryUser
    init(productRepositoryUser: ProductRepositoryUser = ProductRepositoryUserImplementation()) {
        self.productRepositoryUser = productRepositoryUser
        // Beobachtet Änderungen im Suchtext
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchProducts(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    // Beobachtet Produkte für den Benutzer in Echtzeit
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
    
    // Gibt die Anzahl der Favoriten zurück
    func favoriteCount() -> Int {
        return favoriteProducts.count
    }
    
    // Zeigt alle Produkte ohne Filter an
    func showAllProducts() {
        filteredProducts = products
        print("Showing all products. Ohne filter")
    }
    
    // Filtert Produkte nach Kategorie
    func filterProducts(by category: Categories) {
        switch category {
        case .allProducts:
            showAllProducts()
        case .action:
            filteredProducts = products.filter { $0.action }
            print("Filtered products where action is true: \(filteredProducts.count)")
        default:
            filteredProducts = products.filter { $0.category == category.rawValue }
            print("Filtered products by category: \(category.rawValue)")
        }
    }
    
    // Schaltet den Favoritenstatus eines Produkts um
    func toggleFavorite(for product: Product) {
            guard let userID = FirebaseService.shared.userId,
                  let productID = product.id else { return }
        let newFavarite = favoriteProducts.first(where: { $0.id == productID })?.isFavorite ?? false
                  
        
            productRepositoryUser.updateFavoriteStatus(
                userID: userID,
                productID: productID,
                product: product,
                isFavorite: !newFavarite
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
    
    // Lädt die Favoritenprodukte des Benutzers
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
    
    // Durchsucht Produkte basierend auf dem Suchtext
    func searchProducts(searchText: String) {
            if searchText.isEmpty {
                filteredProducts = products
            } else {
                filteredProducts = products.filter { product in
                    product.title.localizedCaseInsensitiveContains(searchText) || // Prüft, ob der Titel des Produkts den Suchtext enthält
                    product.description.localizedCaseInsensitiveContains(searchText) || // Prüft, ob die Beschreibung des Produkts den Suchtext enthält
                    product.category.localizedCaseInsensitiveContains(searchText) || // Prüft, ob die Kategorie des Produkts den Suchtext enthält
                    product.brand.localizedCaseInsensitiveContains(searchText) // Prüft, ob die Marke des Produkts den Suchtext enthält
                }
            }
        }
}
