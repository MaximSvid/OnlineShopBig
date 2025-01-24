//
//  ColorEnum.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

enum ColorEnum: String, CaseIterable, Identifiable {
    case lightBrown
    case sandyBrown
    case caramelBrown
    case chocolateBrown
    case darkBrown
    case walnutBrown
    case beigeBrown
    case taupeBrown
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .lightBrown: return Color(red: 0.87, green: 0.72, blue: 0.53) // Светло-коричневый
        case .sandyBrown: return Color(red: 0.96, green: 0.64, blue: 0.38) // Песочный
        case .caramelBrown: return Color(red: 0.82, green: 0.62, blue: 0.47) // Карамельный
        case .chocolateBrown: return Color(red: 0.55, green: 0.27, blue: 0.07) // Шоколадный
        case .darkBrown: return Color(red: 0.4, green: 0.26, blue: 0.13) // Тёмно-коричневый
        case .walnutBrown: return Color(red: 0.5, green: 0.37, blue: 0.26) // Ореховый
        case .beigeBrown: return Color(red: 0.96, green: 0.87, blue: 0.7) // Бежевый
        case .taupeBrown: return Color(red: 0.72, green: 0.6, blue: 0.5) // Таупе
        }
    }
}
