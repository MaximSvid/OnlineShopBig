//
//  CouponRepositoryUserImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//
import SwiftUI
import Firebase

class CouponRepositoryUserImplementation: CouponRepositoryUser {
    
    private let db = Firestore.firestore()
    
    // Überprüft, ob ein Coupon-Code gültig und aktiv ist
    func validateCoupon(code: String) async throws -> Coupon {
        let snapshot = try await db.collection("coupons")
            .whereField( "code", isEqualTo: code )
            .whereField( "isActive", isEqualTo: true )
            .getDocuments()
        
        guard let document = snapshot.documents.first,
              let coupon = try? document.data(as: Coupon.self) else {
            throw CouponError.invalidCoupon
        }
        
        if coupon.expirationDate < Date() {
            throw CouponError.expired
        }
        return coupon
    }
    
    // Wendet einen Coupon auf einen Betrag an und berechnet den Rabatt
    func applyCoupon(coupon: Coupon, to amount: Double) -> Double {
        switch coupon.discountType {
        case "percentage":
            let discount = amount * (coupon.discountValue / 100.0)
            let finalPrice = amount - discount
            print("Calculating percentage discount:")
            print("Original amount: \(amount)")
            print("Discount percentage: \(coupon.discountValue)%")
            print("Discount amount: \(discount)")
            print("Final price: \(finalPrice)")
            return finalPrice
            
        case "fixed":
            return max(0, amount - coupon.discountValue)
            
        default:
            return amount
        }
    }
}
