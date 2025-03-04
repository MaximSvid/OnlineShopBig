//
//  CustomTitle.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 28.01.25.
//

import SwiftUI

struct CustomTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title)
            .padding([.top, .bottom])
    }
}

