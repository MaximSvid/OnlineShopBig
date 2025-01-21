//
//  CustomButtonWithIsLoading.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 21.01.25.
//

import SwiftUI

struct CustomButtonWithIsLoading: View {
    var action: () -> Void
    var title: String
    var isLoading: Bool = false
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text(title)
                    .font(.headline.bold())
                    .frame(width: .infinity, height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.myPrimaryText)
                    .background(Color.primaryBrown) // В assets
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            }
        }
    }
}

