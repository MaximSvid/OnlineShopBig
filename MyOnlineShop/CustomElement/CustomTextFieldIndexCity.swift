//
//  CustomTextFieldIndexCity.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct CustomTextFieldIndexCity: View {
    let indexPlaceholder: String
    let cityPlaceholder: String
    
    @Binding var index: String
    @Binding var city: String
    
    @FocusState var isIndexFocused: Bool
    @FocusState var isCityFocused: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(indexPlaceholder, text: $index)
                .padding()
                .frame(width: 100)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isIndexFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isIndexFocused)
                .keyboardType(.numberPad)
            
            TextField (cityPlaceholder, text: $city)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isCityFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isCityFocused)
        }
    }
}

#Preview {
//    CustomTextFieldIndexCity()
}
