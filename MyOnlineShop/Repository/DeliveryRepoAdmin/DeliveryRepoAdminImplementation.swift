//
//  DeliveryRepoAdminImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import Firebase

class DeliveryRepoAdminImplementation: DeliveryRepoAdmin {
    
    private let db = Firestore.firestore()
    
    // Fügt eine neue Versandmethode zur Datenbank hinzu
    func addNewDelivery(delivery: DeliveryMethod) throws {
        do {
            try db.collection("delivery").addDocument(from: delivery)
        } catch {
            throw error
        }
    }
    
    // Fügt eine Versandmethode für einen Benutzer hinzu
    func addDeliveryUserMethod(userId: String, deliveryMethod: DeliveryMethod) throws {
        let userDeliveryMethodRef = db.collection("users").document(userId).collection("deliveryMethods").document()
        var data = try Firestore.Encoder().encode(deliveryMethod)
        data["id"] = userDeliveryMethodRef.documentID
        userDeliveryMethodRef.setData(data)
    }
    
    // Beobachtet Änderungen an Versandmethoden und gibt sie zurück
    func observeDelivery(completion: @escaping (Result<[DeliveryMethod], any Error>) -> Void) {
        db.collection("delivery").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let deliveries = documents.compactMap { document -> DeliveryMethod? in
                do {
                    return try document.data(as: DeliveryMethod.self)
                } catch {
                    print("Error: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(.success(deliveries))
        }
    }
    
    // Entfernt eine Versandmethode aus der Datenbank
    func deleteDelivery(deliveryId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        db.collection("delivery").document(deliveryId).delete { err in
            if let err {
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Aktualisiert eine bestehende Versandmethode in der Datenbank
    func updateDelivery(delivery: DeliveryMethod) throws {
        guard let deliveryId = delivery.id else {
            throw NSError(domain: "DeliveryRepoAdminImplementation", code: -1)
        }
        do {
            try db.collection("delivery").document(deliveryId).setData(from: delivery, merge:  true)
        } catch {
            throw error
        }
    }
    
    // Entfernt alle Versandmethoden eines Benutzers
    func deleteDeliveryFromUser(userId: String) async throws {
        let deliveryRef = db.collection("users").document(userId).collection("deliveryMethods")
        
        let snapshot = try await deliveryRef.getDocuments()
        
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }

}
