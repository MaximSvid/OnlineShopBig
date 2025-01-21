//
//  CustomTextField.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .foregroundStyle(Color.primaryBrown)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(isFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
            )
            .focused($isFocused)
    }
}





#Preview {
//    CustomTextField()
}
