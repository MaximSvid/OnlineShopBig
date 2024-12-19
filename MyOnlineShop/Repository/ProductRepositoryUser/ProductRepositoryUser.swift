//
//  ProductRepositoryUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

protocol ProductRepositoryUser {
    func observeProductsUser(completion: @escaping (Result<[Product], Error>) -> Void)
    func updatefavoriteStatus(product: Product, isFavorite: Bool, completion: @escaping (Result<Void, Error>) -> Void)
}
