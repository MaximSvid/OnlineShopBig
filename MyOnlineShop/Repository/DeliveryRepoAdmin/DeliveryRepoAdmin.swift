//
//  DeliveryRepoAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

protocol DeliveryRepoAdmin {
    func addNewDelivery(delivery: DeliveryMethod) throws
    func observeDelivery(completion: @escaping (Result<[DeliveryMethod], Error>) -> Void)
    func deleteDelivery(deliveryId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func updateDelivery(delivery: DeliveryMethod) throws
    func addDeliveryUserMethod(userId: String, deliveryMethod: DeliveryMethod) throws
    func deleteDeliveryFromUser(userId: String) async throws
}
