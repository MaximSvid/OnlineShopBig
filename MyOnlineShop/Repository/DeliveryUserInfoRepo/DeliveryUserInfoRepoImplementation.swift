//
//  DeliveryUserInfoRepoImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import Firebase

class DeliveryUserInfoRepoImplementation: DeliveryUserInfoRepo {
    
    private let db = Firestore.firestore()
    
    func addDeliveryUserInfo(userId: String, deliveryInfo: DeliveryUserInfo) throws {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo").document()
        var data = try Firestore.Encoder().encode(deliveryInfo)
        data["id"] = userDeliveryInfoRef.documentID
        try userDeliveryInfoRef.setData(data)
    }
    
    // Здесь ошибка, тебе не нужен array, тебе нужне только один обект
    func observeDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void) {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
        
        userDeliveryInfoRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            let deliveryInfos = documents.compactMap { document -> DeliveryUserInfo? in
                try? document.data(as: DeliveryUserInfo.self)
            }
            completion(.success(deliveryInfos))
        }
    }
    
    func deleteDeliveryUserInfoFromUser(userId: String) async throws {
        let deliveryUserInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
        
        let snapshot = try await deliveryUserInfoRef.getDocuments()
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
    
//    func deleteDeliveryUserInfoFromUser(userId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
//        let deliveryUserInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
//        deliveryUserInfoRef.getDocuments { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let documents = snapshot?.documents else {
//                completion(.success(()))
//                return
//            }
//            for document in documents {
//                document.reference.delete()
//            }
//            completion(.success(()))
//        }
//    }

    
}

