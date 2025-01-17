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

    func observeReceipts() async throws -> [Receipt] {
        let usersRef = db.collection("users")
        //            .collection("receipts")
        
        let userSnapshot = try await usersRef.getDocuments()
        print("Number on users \(userSnapshot.documents.count)")
        
        var allReceipts: [Receipt] = []
        
        for userDocument in userSnapshot.documents {
            let receiptsRef = userDocument.reference.collection("receipts")
            
            let receiptsSnapshot = try await receiptsRef.getDocuments()
            print("User \(userDocument.documentID) has  \(receiptsSnapshot.documents.count)")
            
            let receipts = try receiptsSnapshot.documents.compactMap { document -> Receipt? in
                try document.data(as: Receipt.self)
            }
            allReceipts.append(contentsOf: receipts)
        }
        print("Count receipts \(allReceipts.count)")
        return allReceipts
    }
    
    func updateOrderStatus(receiptId: String, newStatus: OrderSatatus)  async throws {
        let userRef = db.collection("users")
        
        let userSnapshot = try await userRef.getDocuments()
        print("Number on users \(userSnapshot.documents.count)")
        
        for userDocument in userSnapshot.documents {
            let receiptsRef = userDocument.reference.collection("receipts").document(receiptId)
            
            try await receiptsRef.updateData(["orderStatus": newStatus.rawValue])
            
        }
    }
}
