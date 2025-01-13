//
//  PaymentAdminRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//
import SwiftUI
import Firebase

class PaymentAdminRepositoryImplementation: PaymentAdminRepository {

    private let db = Firestore.firestore()
    
    func observePayment(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
        db.collection("payments").addSnapshotListener { snapshot, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let payments = documents.compactMap { document -> PaymentMethod? in
                do {
                    return try document.data(as: PaymentMethod.self)
                } catch {
                    print("Error decoding payment: \(error)")
                    return nil
                }
            }
            completion(.success(payments))
        }
    }
    
    func toggleVisibility(for paymentId: String, isVisible: Bool, completion: @escaping (Result<Void, any Error>) -> Void) {
        db.collection("payments").document(paymentId).updateData(["isVisible": isVisible]) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
