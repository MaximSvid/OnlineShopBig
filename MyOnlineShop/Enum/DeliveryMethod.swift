//
//  DeliveryMethod.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//
enum DeliveryMethod: CaseIterable {
    case deutschePost
    case dhl
    case hermes
    
    var name: String {
        switch self {
        case .deutschePost: return "Deutsche Post"
        case .dhl: return "DHL"
        case .hermes: return "Hermes"
        }
    }
    
    var price: Double {
        switch self {
        case .deutschePost: return 5.00
        case .dhl: return 4.99
        case .hermes: return 4.59
        }
    }
    
    var estimatedDeliveryTime: String {
        switch self {
        case .deutschePost: return "1-2 Werktage"
        case .dhl: return "1-3 Werktage"
        case .hermes: return "1-2 Werktage"
        }
    }
}
