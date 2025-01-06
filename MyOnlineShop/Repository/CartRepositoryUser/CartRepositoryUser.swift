//
//  CartRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

protocol CartRepositoryUser {
    func getToCart(userId: String, productId: String, product: Product, completion: @escaping (Result<Void, Error>) -> Void)
    func loadCartProducts(userId: String, completion: @escaping (Result<[Product], Error>) -> Void)
    func updateCountProduct (userId: String, productId: String, productCount: Int, completion: @escaping (Result<Void, any Error>) -> Void)
    func removeFromCart(userId: String, productId: String, completion: @escaping (Result<Void, any Error>) -> Void)
}
