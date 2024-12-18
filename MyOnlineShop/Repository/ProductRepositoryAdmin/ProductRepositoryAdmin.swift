//
//  ProductRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 18.12.24.
//

protocol ProductRepositoryAdmin {
    func addNewProduct(product: Product) throws
    func observeProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func deleteProduct(productId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func toggleVisibility(for productId: String, isVisible: Bool, completion: @escaping (Result<Void, Error>) -> Void)
    
}
