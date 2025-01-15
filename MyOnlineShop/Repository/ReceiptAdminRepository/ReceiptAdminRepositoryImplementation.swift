//
//  ReseiptAdminRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//
import SwiftUI
import FirebaseFirestore

class ReceiptAdminRepositoryImplementation: ReceiptAdminRepository {
    
    private let db = Firestore.firestore()
    
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
        let receiptRef = db.collection("receipts").document(receiptId)
        try await receiptRef.updateData([
            "orderStatus": newStatus.rawValue
        ])
    }
    
    
}
