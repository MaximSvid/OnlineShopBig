//
//  DeliveryUserInfoRepo.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

protocol DeliveryUserInfoRepo {
    
    func addDeliveryUserInfo(userId: String, deliveryInfo: DeliveryUserInfo) throws
    func observeDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], Error>) -> Void)
    
    func deleteDeliveryUserInfoFromUser(userId: String, completion: @escaping (Result<Void, Error>) -> Void)

//    func getToDeliveryInfo(userId: String, deliveryInfoId: String, deliveryInfo: String, completion: @escaping (Result<Void, Error>) -> Void)
//    func loadDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], Error>) -> Void)
//    
//    //falsche richtung...collection user soll deliveryUserRepo haben...
//    
//    func addDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws
//    func observeDeliveryUserInfo(completion: @escaping (Result<[DeliveryUserInfo], Error>) -> Void)
//    func updateDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws
}

