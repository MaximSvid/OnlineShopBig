//
//  Delivery.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//
import SwiftUI
import FirebaseFirestore
/**
 * Struktur, die eine Liefermethode in Firebase repräsentiert.
 * Enthält eine optionale ID, den Namen der Liefermethode, den Preis und die Lieferzeit.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore, ist optional und zunächst `nil`.
 */
struct DeliveryMethod: Identifiable, Codable {
    @DocumentID var id: String?                 // soll immer optionla sein. am anfang id = nil
    
    var deliveryName: String
    var deliveryPrice: Double
    var deliveryTime: String
}

    
   
