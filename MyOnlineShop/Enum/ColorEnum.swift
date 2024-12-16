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
    case black
    case white
    
    var id: String {self.rawValue}
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .green: return Color.green
        case .blue: return Color.blue
        case .black: return Color.black
        case .white: return Color.white
        }
    }
}
