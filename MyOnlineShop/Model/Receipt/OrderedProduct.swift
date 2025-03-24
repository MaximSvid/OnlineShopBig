//
//  OrderedProduct.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.03.25.
//
import SwiftUI

/**
 * Struktur, die ein bestelltes Produkt in einer Bestellung repräsentiert.
 * Enthält eine ID sowie Details wie Bilder, Titel, Menge, Einzelpreis und Gesamtpreis des Produkts.
 * Konform zu `Codable` für JSON-Serialisierung und `Identifiable` für SwiftUI.
 */
struct OrderedProduct: Codable, Identifiable {
    var id: String
    var images: [String]
    var title: String
    var quantity: Int                             // Anzahl der gekauften Einheiten
    var pricePerUnit: Double                      // Preis pro Einheit
    var totalPrice: Double                        // Gesamtkosten der Position
    
    var productId: String                         // Verweis auf das ursprüngliche Produkt
}
