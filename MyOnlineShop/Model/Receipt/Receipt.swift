//
//  Check.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//
import SwiftUI
import FirebaseFirestore

/**
 * Struktur, die eine Quittung (Bestellbeleg) in Firebase repräsentiert.
 * Enthält eine optionale ID sowie Informationen zu bestellten Produkten, Preisen, Lieferdetails, Zahlungsmethode und Bestellstatus.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore, ist optional.
 */
struct Receipt: Identifiable, Codable {
    @DocumentID var id: String?
    
    var products: [OrderedProduct]                 // Enthält Informationen zu den bestellten Produkten
    var totalProductPrice: Double                  // Gesamtkosten der Produkte
    var totalDeliveryPrice: Double                 // Lieferkosten
    var finalTotalPrice: Double                    // Endgültige Gesamtsumme (inklusive Lieferung und Rabatte)
    
    var userInfo: DeliveryUserInfo
    var deliveryMethod: DeliveryMethod
    var paymentMethod: PaymentMethod
    
                                                   // Allgemeine Informationen zur Quittung
    var dateCreated: Date = Date()
    var userId: String
    
    var orderStatus: OrderStatus
}



