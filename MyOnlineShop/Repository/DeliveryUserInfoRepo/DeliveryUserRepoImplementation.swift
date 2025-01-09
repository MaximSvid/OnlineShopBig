//
//  DeliveryUserInfoRepoImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import Firebase

class DeliveryUserRepoImplementation: DeliveryUserRepo {
    
    private let db = Firestore.firestore()
    
    func addDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws {
        do {
            try db.collection("deliveryUserInfo").addDocument(from: deliveryUserInfo)
        } catch {
            throw error
        }
    }
    
    func observeDeliveryUserInfo(completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void) {
        db.collection("deliveryUserInfo").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            let deliveryUserInfo = documents.compactMap { document -> DeliveryUserInfo? in
                do {
                    return try document.data(as: DeliveryUserInfo.self)
                } catch {
                    print("Error \(error)")
                    return nil
                }
            }
            completion(.success(deliveryUserInfo))
        }
    }
    
    func updateDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws {
        guard let diliveryUserInfoId = deliveryUserInfo.id else {
            throw NSError(domain: "No deliveryUserInfoId", code: -1)
        }
        do {
            try db.collection("deliveryUserInfo").document(diliveryUserInfoId).setData(from: deliveryUserInfo)
        } catch {
            throw error
        }
    }
}

