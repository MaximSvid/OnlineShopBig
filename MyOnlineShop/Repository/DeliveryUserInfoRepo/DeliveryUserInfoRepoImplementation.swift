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
    
    // Fügt Lieferinformationen für einen Benutzer hinzu
    func addDeliveryUserInfo(userId: String, deliveryInfo: DeliveryUserInfo) throws {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo").document()
        var data = try Firestore.Encoder().encode(deliveryInfo)
        data["id"] = userDeliveryInfoRef.documentID
        userDeliveryInfoRef.setData(data)
    }
    
    // Beobachtet Änderungen an den Lieferinformationen eines Benutzers
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
    
    // Entfernt alle Lieferinformationen eines Benutzers
    func deleteDeliveryUserInfoFromUser(userId: String) async throws {
        let deliveryUserInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
        
        let snapshot = try await deliveryUserInfoRef.getDocuments()
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
    
    // Aktualisiert die Lieferinformationen eines Benutzers
    func updateUserInfo(newDeliveryUserInfo: DeliveryUserInfo) throws {
        guard let userId = FirebaseService.shared.userId,
        let deliveryUserUnfoId = newDeliveryUserInfo.id
        else {
            throw NSError(domain: "No deliveryUserInfoId", code: -1)
        }
        do {
            try db
                .collection("users")
                .document(userId)
                .collection("userDeliveryInfo")
                .document(deliveryUserUnfoId)
                .setData(from: newDeliveryUserInfo)
        } catch {
            throw error
        }
    }
    
    // Prüft, ob Lieferinformationen für einen Benutzer existieren
    func checkIfDeliveryUserInfoExists(userId: String, completion: @escaping (Bool) -> Void) {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
        userDeliveryInfoRef.getDocuments { QuerySnapshot, error in
            if error != nil {
                completion(false)
                print("Error checkIfDeliveryUserInfoExist")
                return
            }
            completion(!QuerySnapshot!.documents.isEmpty)
        }
    }
}

