//
//  CustomTitleRow.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 28.01.25.
//

import SwiftUI

struct CustomTitleRow: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
        }
    }
}
