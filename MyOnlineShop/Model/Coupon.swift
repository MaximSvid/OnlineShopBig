//
//  Coupon.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//
import SwiftUI
import FirebaseFirestore

/**
 * Struktur, die einen Coupon in Firebase repräsentiert.
 * Enthält eine eindeutige ID, den Coupon-Code, Rabattyp, Rabattwert, Ablaufdatum und Aktivitätsstatus.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` для SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore.
 */
struct Coupon: Identifiable, Codable {
    @DocumentID var id: String?
    
    var code: String
    var discountType: String
    var discountValue: Double
    var expirationDate: Date
    var isActive: Bool = false
}
