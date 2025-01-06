//
//  UserCartViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI
import Firebase

@MainActor
class UserCartViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    private let cartRepositoryUser: CartRepositoryUser
    
    init(cartRepositoryUser: CartRepositoryUser = CartRepositoryUserImplementation()) {
        self.cartRepositoryUser = cartRepositoryUser
    }
    
    func addToCart(for product: Product) {
        guard let userId = FirebaseService.shared.userId,
              let productId = product.id else {
            print("Error add to cart")
            return
        }
        
        cartRepositoryUser.getToCart(
            userId: userId,
            productId: productId,
            product: product) { result in
                switch result {
                case .success:
                    print("Add to cart \(productId)")
                    self.loadCart()
                case .failure(let error):
                    print("Error add to cart \(error)")
                }
            }
    }
    
    func loadCart() {
        guard let userId = FirebaseService.shared.userId else {
            return
        }
        cartRepositoryUser.loadCartProducts(userId: userId) { [weak self] result in
            //weak self - против утечек памяти
            switch result {
            case .success(let products):
                self?.products = products
            case .failure(let error):
                print("Error load cart \(error)")
            }
        }
    }
    
    var totalSum: Double {
        products.reduce(0) {sum, product in
            if product.action && product.actionPrice > 0 {
                return sum + product.actionPrice
            } else {
                return sum + product.price
            }
        }
    }
    var cartItemsCount: Int {
        products.count
    }
    
    func updateCountProducts(for product: Product, increment: Bool) {
        //increment Increment — это термин, который обычно используется для обозначения увеличения значения на определённое число, чаще всего на единицу. В программировании это очень часто встречающаяся операция, которая используется для работы с числовыми переменными, счётчиками или для изменения значения в циклах, интерфейсах и других сценариях.
        guard let userId = FirebaseService.shared.userId,
              let productId = product.id,
              let index = products.firstIndex(where: { $0.id == productId }) else {
            return
        }
        
        var updateProduct = product
        if increment {
            updateProduct.countProduct += 1
        } else {
            updateProduct.countProduct -= 1
        }
        
        if updateProduct.countProduct <= 0 {
            removeFromCart(product: product)
            return
        }
        cartRepositoryUser.updateCountProduct(
            userId: userId,
            productId: productId,
            productCount: updateProduct.countProduct) { [weak self] result in
                switch result {
                case .success:
                    self?.loadCart()
                    
                case .failure(let error):
                    print("Error update count product: \(error.localizedDescription)")
                }
            }
    }
    
    func removeFromCart(product: Product) {
        guard let userId = FirebaseService.shared.userId,
              let productId = product.id else { return }
        
        cartRepositoryUser.removeFromCart(
            userId: userId,
            productId: productId
        ) { [weak self] result in
            switch result {
            case .success:
                self?.loadCart()
            case .failure(let error):
                print("Error removing from cart: \(error)")
            }
        }
    }
    
}
