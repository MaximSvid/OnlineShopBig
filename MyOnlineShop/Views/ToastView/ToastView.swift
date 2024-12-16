//
//  ToastView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI
    // не испльзую

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width: CGFloat = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack (alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundStyle(style.themeColor)
            Text(message)
                .font(.caption)
//                .foregroundStyle(style.themeColor)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(style.themeColor)
            }
        }
        .padding()
        .clipShape(.buttonBorder)
        
    }
}

#Preview {
//    ToastView()
}
