//
//  Product.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//
/**
  Protokoll (protocol) - eine Sammlung von Anforderungen, die festlegen, welche Methoden, Eigenschaften und anderen Elemente in einem entsprechenden Typ (Klasse, Struktur oder Aufzählung) implementiert werden müssen.
 1. Codable: Dieses Protokoll wird verwendet, um Objekte in ein externes Darstellungsformat (wie JSON oder Property List) zu kodieren und zu dekodieren. Es vereinfacht die Arbeit mit Daten, die gespeichert oder übertragen werden müssen.
 2. Identifiable: Dieses Protokoll stellt sicher, dass jedes Objekt eine eindeutige Identität hat, was besonders nützlich ist, wenn Objekte in Listen oder Sammlungen verwaltet werden. Es erleichtert die Identifizierung und Verwaltung von Objekten.
 3. Equatable: Dieses Protokoll ermöglicht es, Objekte auf Gleichheit zu überprüfen. Es ist nützlich, um festzustellen, ob zwei Objekte denselben Wert haben, was in vielen Algorithmen und Datenstrukturen erforderlich ist.
 4. Hashable: Dieses Protokoll erweitert Equatable und ermöglicht es, Objekte in Sammlungen zu verwenden, die Hashing erfordern, wie z.B. Sets oder Dictionaries. Es stellt sicher, dass Objekte eindeutig und effizient gespeichert und abgerufen werden können.
 */

import SwiftUI
import FirebaseFirestore

struct Product: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    
    var title: String
    var price: Double
    var actionPrice: Double = 0.0
    var description: String = ""
    var brand: String = ""
    var countProduct: Int = 0
    var purchasedQuantity: Int = 0 
    var category: String = ""
    var images: [String] = []
    var rating: Double = 0.0
    var isVisible: Bool = true
    var selectedColor: String = ""
    var isFavorite: Bool = false
    var action: Bool = false
    var dateCreated: Date = Date()
}

