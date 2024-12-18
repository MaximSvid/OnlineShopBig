//
//  ProductRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 18.12.24.
//

protocol ProductRepositoryAdmin {
    func addNewProduct(product: Product) throws
    func observeProducts()
    func deleteProduct(product: Product)
    func toggleVisibility(for product: Product)
    func showAllProducts()
}
