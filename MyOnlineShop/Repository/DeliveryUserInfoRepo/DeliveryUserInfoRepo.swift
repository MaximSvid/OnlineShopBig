//
//  DeliveryUserInfoRepo.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

protocol DeliveryUserInfoRepo {
    
    func addDeliveryUserInfo(userId: String, deliveryInfo: DeliveryUserInfo) throws
    func observeDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], Error>) -> Void)
    
    func deleteDeliveryUserInfoFromUser(userId: String) async throws
}

