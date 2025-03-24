//
//  FireUserGuest.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import Foundation
import FirebaseFirestore

/**
 * Struktur, die einen Benutzer in Firebase repräsentiert.
 * Enthält grundlegende Informationen wie ID, Registrierungsdatum, Name und Rolle.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 */

struct FireUser: Codable, Identifiable {
    var id: String
    var registeredOn: Date = Date()

    var name: String
    var role: String
}

