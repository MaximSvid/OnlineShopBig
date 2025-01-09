//
//  DeliveryRepoAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

protocol DeliveryRepoAdmin {
    func addNewDelivery(delivery: Delivery) throws
    func observeDelivery(completion: @escaping (Result<[Delivery], Error>) -> Void)
    func deleteDelivery(deliveryId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func updateDelivery(delivery: Delivery) throws
}
