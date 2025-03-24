//
//  BunnerImage.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//
import SwiftUI
import FirebaseFirestore

/**
 * Struktur, die ein Banner im Firebase repräsentiert.
 * Enthält eine eindeutige ID, den Namen des Banners und eine Liste von Bild-URLs.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 * `@DocumentID` markiert die ID als Dokument-ID in Firestore.
 */
struct Banner: Codable, Identifiable {
    @DocumentID var id: String?
    
    var bannerName: String
    var bannerImage: [String] = []
}
