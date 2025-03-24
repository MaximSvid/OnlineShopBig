//
//  PaymentMethod.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//
import SwiftUI
import FirebaseFirestore

/**
 * Struktur, die eine Zahlungsmethode in Firebase repräsentiert.
 * Enthält eine optionale ID, den Namen, ein Bild, eine optionale Beschreibung und einen Sichtbarkeitsstatus.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore, ist optional.
 */

struct PaymentMethod: Identifiable, Codable {
    @DocumentID var id: String?
    
    var name: String
    var image: String
    var description: String = ""
    var isVisible: Bool 
}
