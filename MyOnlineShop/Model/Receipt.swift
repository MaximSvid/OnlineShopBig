//
//  Check.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//
import SwiftUI
import FirebaseFirestore

struct Receipt: Identifiable, Codable {
    @DocumentID var id: String?
    
    var products: [Product]
    var totalProductPrice: Double
    
    var userInfo: DeliveryUserInfo
    
    var deliveryMethod: DeliveryMethod
    
    var paymentMethod: PaymentMethod
    
        // общая информация о чеке
    var totalPrice: Double
    var orderStatus: OrderSatatus
    var dateCreated: Date = Date()
//    var userId: String
}

enum OrderSatatus: String, Codable {
    case new = "new"
    case processing = "processing"
    case shipped = "shipped"
    case delivered = "delivered"
    case cancelled = "cancelled"
}
