//
//  CheckUserRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI
import Firebase

class ReceiptUserRepositoryImplementation: ReceiptUserRepository {
    
    private let db = Firestore.firestore()
    
    func addNewCheck(receipt: Receipt) throws {
        do {
            try db.collection("receipts").addDocument(from: receipt)
        } catch {
            throw error
        }
    }
    
    func fetchCheck(completion: @escaping (Result<[Receipt], any Error>) -> Void) {
        db.collection("receipts").addSnapshotListener { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let receipts = documents.compactMap { document -> Receipt? in
                do {
                    return try document.data(as: Receipt.self)
                } catch {
                    print("Error decoding document: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(.success(receipts))
        }
    }
    
    
}
