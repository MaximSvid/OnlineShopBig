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
    
    func updateOrderStatus(receiptId: String, newStatus: OrderStatus) async throws {
        let usersRef = db.collection("users")
        let userSnapshot = try await usersRef.getDocuments()
        
        var documentFound = false
        
        for userDocument in userSnapshot.documents {
            let receiptsRef = userDocument.reference.collection("receipts").document(receiptId)
            
            do {
                // Попробуем обновить, если документ существует
                try await receiptsRef.updateData(["orderStatus": newStatus.rawValue])
                documentFound = true
                print("Order status updated for receiptId: \(receiptId)")
            } catch {
                print("Receipt not found in user: \(userDocument.documentID)")
            }
        }
        
        if !documentFound {
            throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Receipt with id \(receiptId) not found."])
        }
    }
    
    func observeOrderStatus(receiptId: String, userId: String, completion: @escaping (Result<OrderStatus, Error>) -> Void) {
        let receiptsRef = db.collection("users")
            .document(userId)
            .collection("receipts")
            .document(receiptId)
        
        receiptsRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists,
                  let data = snapshot.data(),
                  let statusString = data["orderStatus"] as? String,
                  let status = OrderStatus(rawValue: statusString) else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid or missing data."])))
                return
            }
            
            completion(.success(status))
        }
    }
}
