//
//  CustomTextFieldStreetHouseCity.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct CustomTextFieldStreetHouseCity: View {
    let streetPlaceholder: String
    let housePlaceholder: String
    let apartmentPlaceholder: String
    
    @Binding var street: String
    @Binding var house: String
    @Binding var apartment: String
    
    @FocusState var isStreetFocused: Bool
    @FocusState var isHouseFocused: Bool
    @FocusState var isApartmentFocused: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(streetPlaceholder, text: $street)
                .padding()
                .frame(width: 150)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isStreetFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isStreetFocused)
            
            TextField(housePlaceholder, text: $house)
                .padding()
                .frame(width: 80)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isHouseFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isHouseFocused)
                .keyboardType(.numberPad)
            
            TextField(apartmentPlaceholder, text: $apartment)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(isApartmentFocused ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .focused($isApartmentFocused)
                .keyboardType(.numberPad)

        }
    }
}
