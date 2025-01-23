//
//  Category.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.12.24.
//
import SwiftUI

enum Categories: String, CaseIterable {
    case allProducts = "Categories_AllProducts"
    case action = "Categories_Action"
    case livingRoom = "Categories_LivingRoom"
    case bedroom = "Categories_Bedroom"
    case kitchen = "Categories_Kitchen"
    case office = "Categories_Office"
    case diningRoom = "Categories_DiningRoom"
    case bathroom = "Categories_Bathroom"
    case decor = "Categories_Decor"
    case lighting = "Categories_Lighting"
    
    var icon: String {
        switch self {
        case .allProducts: return "list.bullet.clipboard"
        case .action: return "tag"
        case .livingRoom: return "sofa"
        case .bedroom: return "bed.double"
        case .kitchen: return "cup.and.saucer"
        case .office: return "desktopcomputer"
        case .diningRoom: return "table.furniture"
        case .bathroom: return "shower"
        case .decor: return "paintpalette"
        case .lighting: return "lightbulb"
        }
    }
    
    var title: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
