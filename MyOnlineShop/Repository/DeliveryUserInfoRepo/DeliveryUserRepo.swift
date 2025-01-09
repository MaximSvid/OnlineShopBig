//
//  DeliveryUserInfoRepo.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

protocol DeliveryUserRepo {
    func addDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws
    func observeDeliveryUserInfo(completion: @escaping (Result<[DeliveryUserInfo], Error>) -> Void)
    func updateDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws
}

