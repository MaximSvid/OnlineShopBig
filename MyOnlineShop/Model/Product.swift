//
//  Product.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

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
