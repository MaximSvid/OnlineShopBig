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

    // Fügt eine Zahlungsmethode für einen Benutzer hinzu
    func addDeliveryPaymentMethod(userId: String, paymentMethod: PaymentMethod) throws {
        let userPaymentMethodRef = db.collection("users").document(userId).collection("userPaymentMethod").document()
        
        var data = try Firestore.Encoder().encode(paymentMethod)
        data["id"] = userPaymentMethodRef.documentID
        userPaymentMethodRef.setData(data)
        
    }
    
    // Beobachtet Änderungen an Zahlungsmethoden und gibt sie zurück
    func observePayments(completion: @escaping (Result<[PaymentMethod], Error>) -> Void) {
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
    
    // Schaltet die Sichtbarkeit einer Zahlungsmethode um
    func toggleVisibility(for paymentId: String, isVisible: Bool, completion: @escaping (Result<Void, any Error>) -> Void) {
        db.collection("payments").document(paymentId).updateData(["isVisible": isVisible]) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // Entfernt alle Zahlungsmethoden eines Benutzers
    func deletePaymentFormUser(userId: String) async throws {
        let paymetnsFormUserRef = db.collection("users").document(userId).collection("userPaymentMethod")
        let snapshot = try await paymetnsFormUserRef.getDocuments()
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
}
