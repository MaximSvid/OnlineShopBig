//
//  CustomTextFieldPhone.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct CustomTextFieldPhone: View {
    let countryCodePlaceholder: String
    let phonePlaceholder: String
    @Binding var countryCode: String
    @Binding var phoneNumber: String
    @FocusState var isCountryCodeFocused: Bool
    @FocusState var isPhoneNumberFocused: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(countryCodePlaceholder, text: $countryCode)
                .padding()
                .frame(width: 80)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isCountryCodeFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isCountryCodeFocused)
                .keyboardType(.numberPad)
            
            TextField(phonePlaceholder, text: $phoneNumber)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isPhoneNumberFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isPhoneNumberFocused)
                .keyboardType(.numberPad)
        }
    }
}
