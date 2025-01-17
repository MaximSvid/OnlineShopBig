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
    
    var products: [OrderedProduct] // Изменено для хранения информации о заказанных товарах
    var totalProductPrice: Double  // Общая стоимость товаров
    var totalDeliveryPrice: Double // Стоимость доставки
    var finalTotalPrice: Double    // Итоговая сумма (включая доставку и скидки)
    
    var userInfo: DeliveryUserInfo
    var deliveryMethod: DeliveryMethod
    var paymentMethod: PaymentMethod
    
    // общая информация о чеке
    var dateCreated: Date = Date()
    var userId: String
    
    var orderStatus: OrderSatatus
}

struct OrderedProduct: Codable, Identifiable {
    var id: String
    var images: [String]
    var title: String
    var quantity: Int          // Количество купленных единиц
    var pricePerUnit: Double   // Цена за единицу
    var totalPrice: Double     // Общая стоимость позиции
    
    var productId: String      // Ссылка на оригинальный товар
}


enum OrderSatatus: String, Codable, CaseIterable {
    case new = "new"
    case processing = "processing"
    case shipped = "shipped"
    case delivered = "delivered"
    case cancelled = "cancelled"
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .new: return .gray
        case .processing: return .green
        case .shipped: return .blue
        case .delivered: return .yellow
        case .cancelled: return .red
        }
    }
}
