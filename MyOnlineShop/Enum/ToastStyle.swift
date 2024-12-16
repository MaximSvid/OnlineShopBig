//
//  ToastStyle.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return .red
        case .warning: return .yellow
        case .success: return .green
        case .info: return .blue
        }
    }
    
    var iconFileName: String {
        switch self {
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
}
