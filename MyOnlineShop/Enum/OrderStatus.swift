//
//  OrderStatus.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.03.25.
//
import SwiftUI

enum OrderStatus: String, Codable, CaseIterable {
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
