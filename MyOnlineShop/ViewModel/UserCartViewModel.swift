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
              let productId = product.id,
              let index = products.firstIndex(where: { $0.id == productId }) else {
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
        cartRepositoryUser.loadCartProducts(userId: userId) { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print("Error load cart \(error)")
            }
        }
    }
}
