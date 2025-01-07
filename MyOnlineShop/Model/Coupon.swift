//
//  Coupon.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//
import SwiftUI
import FirebaseFirestore

struct Coupon: Identifiable, Codable {
    @DocumentID var id: String?
    
    var code: String
    var discountType: String // Тип скидки (discountType): процент (percentage) или фиксированная сумма (fixed).
    var discountValue: Double
    var expirationDate: Date
    var isActive: Bool = false
    
}
