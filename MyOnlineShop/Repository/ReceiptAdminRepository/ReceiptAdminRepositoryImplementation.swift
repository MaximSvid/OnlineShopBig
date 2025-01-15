//
//  ReseiptAdminRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ReceiptAdminRepositoryImplementation: ReceiptAdminRepository {
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
    
    
    func observeReceipts() async throws -> [Receipt] {
        let receiptsRef = db.collection("receipts")
        
        let snapshot = try await receiptsRef
            .order(by: "dateCreated")
            .getDocuments()
        
        let receipts = try snapshot.documents.compactMap { document -> Receipt? in
            try document.data(as: Receipt.self)
        }
        return receipts
    }
    
    func updateOrderStatus(receiptId: String, newStatus: OrderSatatus) async throws {
        
        guard try await checkAdminStatus() else {
                    throw NSError(domain: "Auth", code: -1)
                }

        
        let receiptRef = db.collection("receipts").document(receiptId)
        try await receiptRef.updateData([
            "orderStatus": newStatus.rawValue
        ])
    }
    
    private func checkAdminStatus() async throws -> Bool {
            guard let userId = auth.currentUser?.uid else {
                throw NSError(domain: "Auth", code: -1)
            }
            
            let userDoc = try await db.collection("users").document(userId).getDocument()
            guard let user = try? userDoc.data(as: FireUser.self) else {
                return false
            }
            return user.role == "admin" // или какое у вас значение для админа
        }
}
