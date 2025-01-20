//
//  CustomInfoRow.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI

struct CustomInfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text ("\(title): ")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Text(value)
                .font(.body)
            
            Spacer()
        }
    }
}

