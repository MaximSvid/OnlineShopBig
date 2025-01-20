//
//  ContaiterRechtangle.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct ContaiterRechtangle<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 20) {
            content
        }
        .padding([.top, .bottom])
        .background(
            RoundedRectangle(cornerRadius: 3)
                .stroke(.gray.opacity(0.8), lineWidth: 1)
        )
    }
}

