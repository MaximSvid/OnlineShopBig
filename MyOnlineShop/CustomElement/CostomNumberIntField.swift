//
//  CostomNumberIntField.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 27.01.25.
//

import SwiftUI

struct CostomNumberIntField: View {
    let placeholder: String
    @Binding var value: Int
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, value: $value, format: .number)
            .padding()
            .foregroundStyle(Color.primaryBrown)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(isFocused ? Color.primaryBrown : Color.secondaryGray, lineWidth: 1)
            )
            .focused($isFocused)
    }
}
