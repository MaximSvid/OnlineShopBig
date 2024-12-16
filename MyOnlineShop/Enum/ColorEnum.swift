//
//  ColorEnum.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

enum ColorEnum: String, CaseIterable, Identifiable {
    case red
    case green
    case blue
    case yellow
    case orange
    case purple
    case pink
    case gray
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .green: return Color.green
        case .blue: return Color.blue
        case .yellow: return Color.yellow
        case .orange: return Color.orange
        case .purple: return Color.purple
        case .pink: return Color.pink
        case .gray: return Color.gray
        }
    }
}
