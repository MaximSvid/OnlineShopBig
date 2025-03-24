//
//  DeliveryUserInfo.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import FirebaseFirestore

/**
 * Struktur, die Lieferinformationen eines Benutzers in Firebase repräsentiert.
 * Enthält eine optionale ID sowie persönliche Daten wie Name, E-Mail, Telefonnummer und Adressdetails.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore, ist optional.
 */
struct DeliveryUserInfo: Identifiable, Codable {
    @DocumentID var id: String?
    
    var firstName: String
    var lastName: String
    var email: String
    
    var countryCode: String = ""
    var phoneNumber: String
    
    var country: String
    var index: String
    var city: String
    var street: String
    var houseNumber: String
    var apartmentNumber: String = ""

}
