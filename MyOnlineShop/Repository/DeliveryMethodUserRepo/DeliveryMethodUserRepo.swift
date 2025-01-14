//
//  DeliveryMethodUserRepo.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

protocol DeliveryMethodUserRepo {
    func addDeliveryUserMethod(userId: String, deliveryMethod: DeliveryMethod) throws
    func observeDeliveryUserMethods(userId: String, completion: @escaping (Result<[DeliveryMethod], Error>) -> Void)
}
