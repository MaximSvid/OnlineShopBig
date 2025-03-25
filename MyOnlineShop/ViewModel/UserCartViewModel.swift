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
    @Published var itemCount: [Product: Int] = [:]
    
    private let cartRepositoryUser: CartRepositoryUser
    
    init(cartRepositoryUser: CartRepositoryUser = CartRepositoryUserImplementation()) {
        self.cartRepositoryUser = cartRepositoryUser
        loadCart() // Lädt den Warenkorb, um die Anzahl der Produkte anzuzeigen
    }
    
    // Aktualisiert die Produktanzahl im Warenkorb
    func updateCountGoods() {
        for product in products {
            let orderedQuantity = itemCount[product] ?? 0
            guard let productId = product.id else { continue }
            
            let newCount = product.countProduct - orderedQuantity
            try? cartRepositoryUser.updateCountGoods(productId: productId, countProduct: newCount)
        }
    }
        
    // Fügt ein Produkt dem Warenkorb hinzu
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
    
    // Lädt die Produkte aus dem Warenkorb
    func loadCart() {
        guard let userId = FirebaseService.shared.userId else {
            return
        }
        cartRepositoryUser.loadCartProducts(userId: userId) { [weak self] result in
            // weak self wird verwendet, um Speicherlecks zu vermeiden
            switch result {
            case .success(let products):
                self?.products = products
            case .failure(let error):
                print("Error load cart \(error)")
            }
        }
    }
    
    // Berechnet die Gesamtsumme des Warenkorbs
    var totalSum: Double {
        products.reduce(0) { sum, product in
                let count = itemCount[product] ?? 1
                if product.action && product.actionPrice > 0 {
                    return sum + (product.actionPrice * Double(count))
                } else {
                    return sum + (product.price * Double(count))
                }
            }    }
    
    // Gibt die Anzahl der Elemente im Warenkorb zurück
    var cartItemsCount: Int {
        products.count
    }
    
    // Aktualisiert die Anzahl eines Produkts im Warenkorb (erhöht oder verringert)
    func updateCountProducts(for product: Product, increment: Bool) {
        // increment - Increment ist ein Begriff, der üblicherweise verwendet wird, um die Erhöhung eines Wertes um eine bestimmte Zahl, meistens um eins, zu bezeichnen. In der Programmierung ist dies eine sehr häufig vorkommende Operation, die bei der Arbeit mit numerischen Variablen, Zählern oder zur Änderung von Werten in Schleifen, Benutzeroberflächen und anderen Szenarien genutzt wird.
        guard let userId = FirebaseService.shared.userId,
              let productId = product.id else {
            return
        }
        
        let currentCount = itemCount[product] ?? 0
        
        let newCount = increment ? currentCount + 1 : currentCount - 1
        
        if newCount <= 0 {
            removeFromCart(product: product)
            itemCount[product] = nil
            return
        }
        
        itemCount[product] = newCount
    }
    
    // Entfernt ein Produkt aus dem Warenkorb
    func removeFromCart(product: Product) {
        guard let userId = FirebaseService.shared.userId,
              let productId = product.id else { return }
        
        itemCount[product] = nil
        
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
    
    // Entfernt alle Produkte aus dem Warenkorb
    func removeAllFromCart() async {
        guard let userId = FirebaseService.shared.userId else { return }
        do {
            try await cartRepositoryUser.removeAllFromCart(userId: userId)
            print("Debug: All products removed from cart")
        } catch {
            print("Error removing all products from cart: \(error)")
        }
    }
}
