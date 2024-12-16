//
//  ToastView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width: CGFloat = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
          Image(systemName: style.iconFileName)
            .foregroundColor(style.themeColor)
          Text(message)
            .font(Font.caption)
            .foregroundColor(.black)
          
          Spacer(minLength: 10)
          
          Button {
            onCancelTapped()
          } label: {
            Image(systemName: "xmark")
              .foregroundColor(style.themeColor)
          }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color("toastBackground"))
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .opacity(0.6)
        )
        .padding(.horizontal, 16)
      }
}

#Preview {
//    ToastView()
}
