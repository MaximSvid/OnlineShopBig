//
//  CouponRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI
import Firebase

class CouponRepositoryImplementation: CouponRepository {
    
    private let db = Firestore.firestore()
    
    
    func addNewCoupon(coupon: Coupon) throws {
        do {
            try db.collection("coupons").addDocument(from: coupon)
        } catch {
            throw error
        }
    }
    
    func observeCoupons(completion: @escaping (Result<[Coupon], any Error>) -> Void) {
        db.collection("coupons").addSnapshotListener { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let coupons = documents.compactMap { document -> Coupon? in
                do {
                    return try document.data(as: Coupon.self)
                } catch {
                    print("Error decoding document: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(.success(coupons))
        }
    }
    
    func deleteCoupon(couponId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        db.collection("coupons").document(couponId).delete { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func updateCoupon(coupone: Coupon) throws {
        guard let couponeId = coupone.id else {
            throw NSError(domain: "No coupon id", code: -1)
        }
        do {
            try db.collection( "coupons").document(couponeId).setData(from: coupone, merge: true)
        } catch {
            throw error
        }
    }
}
