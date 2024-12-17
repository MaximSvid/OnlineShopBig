//
//  Category.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.12.24.
//

enum Categories: String, CaseIterable {
    case allProducts
    case livingRoom
    case bedroom
    case kitchen
    case office
    case diningRoom
    case bathroom
    case decor
    case lighting
    
    var icon: String {
        switch self {
        case .allProducts: return "box"
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
        switch self {
        case .allProducts: return "All Products"
        case .livingRoom: return "Living Room"
        case .bedroom: return "Bedroom"
        case .kitchen: return "Kitchen"
        case .office: return "Office"
        case .diningRoom: return "Dining Room"
        case .bathroom: return "Bathroom"
        case .decor: return "Decor"
        case .lighting: return "Lighting"
        }
    }
}
