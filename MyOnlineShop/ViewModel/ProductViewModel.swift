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
    @Published var isEditSheetOpen: Bool = false
    
    @Published var products: [Product] = []
    @Published var selectedProduct: Product? // Редактируемый продукт
    
    @Published var title: String = ""
    @Published var price: Double = 0.0
    @Published var actionPrice: Double = 0.0
    @Published var description: String = ""
    @Published var brand: String = ""
    @Published var countProduct: Int = 0
    @Published var images: [String] = []
    @Published var rating: Double = 0.0
    @Published var isVisible: Bool = true
    @Published var isFavorite: Bool = false
    @Published var action: Bool = false
    
    @Published var productErrorMessage: String = ""
    
    @Published var selectedCategory: Categories? = nil
    @Published var filteredProducts: [Product] = []
    
    private let fb = FirebaseService.shared
    
    private let productRepository: ProductRepositoryAdmin
    
    @Published var imgurViewModel: ImgurViewModel
    
    init(productRepository: ProductRepositoryAdmin = ProductRepositoryImplementation()) {
        self.productRepository = productRepository
        self.imgurViewModel = ImgurViewModel()
        
        self.imgurViewModel.onImagesUploaded = { [weak self] urls in
            self?.images = urls
        }
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
            images: images,
            rating: rating,
            isVisible: isVisible,
            selectedColor: selectedColor.rawValue,
            isFavorite: isFavorite,
            action: action
        )
        
        do {
            try productRepository.addNewProduct(product: newProduct)
            print("Product added successfully: \(newProduct)")
            resetFields()
        } catch {
            print("Error adding new product: \(error)")
        }
    }
    
    @Published var category: Categories = .livingRoom
    @Published var selectedColor: ColorEnum = .caramelBrown
    private func resetFields() {
        title = ""
        price = 0.0
        actionPrice = 0.0
        description = ""
        brand = ""
        countProduct = 0
        category = .livingRoom
        images = []
        rating = 0
        isVisible = true
        selectedColor = .caramelBrown
        isFavorite = false
        action = false
        
        imgurViewModel.resetState()
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
        
        // Удаление продукта из Firestore
        productRepository.deleteProduct(productId: productId) { result in
            switch result {
            case .success:
                // Успешное удаление: обновляем локальный массив
                if let index = self.products.firstIndex(where: { $0.id == productId }) {
                    self.products.remove(at: index)
                }
                print("Product deleted successfully")
            case .failure(let error):
                // Обработка ошибок
                self.productErrorMessage = "Error deleting product: \(error.localizedDescription)"
                print("Error deleting product: \(error.localizedDescription)")
            }
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
    
        // функции для редактирования продукта
    func setSelectedProduct(_ product: Product) {
        self.selectedProduct = product
        self.title = product.title
        self.price = product.price
        self.actionPrice = product.actionPrice
        self.description = product.description
        self.brand = product.brand
        self.countProduct = product.countProduct
        self.category = Categories(rawValue: product.category) ?? .livingRoom
        self.images = product.images
        self.rating = product.rating
        self.isVisible = product.isVisible
        self.selectedColor = ColorEnum(rawValue: product.selectedColor) ?? .caramelBrown
        self.action = product.action
    }
    
    func updateProduct( ) {
        guard let existingProduct = selectedProduct else {
            print("No product selected for update.")
            return
        }
        let updateProduct = Product(
            id: existingProduct.id,
            title: title,
            price: price,
            actionPrice: actionPrice,
            description: description,
            brand: brand,
            countProduct: countProduct,
            category: category.rawValue,
            images: images,
            rating: rating,
            isVisible: isVisible,
            selectedColor: selectedColor.rawValue,
            isFavorite: isFavorite,
            action: action
        )
        do {
            try productRepository.updateProduct(product: updateProduct)
            print("Product updated successfully.")
            if let index = products.firstIndex(where: { $0.id == updateProduct.id }) {
                products[index] = updateProduct
            }
            resetFields()
        } catch {
            print("Error updating product: \(error)")
        }
    }
    
}


