//
//  CustomMainButton.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 21.01.25.
//

import SwiftUI

struct CustomMainButton: View {
    var action: () -> Void // это замыкание(Clousure) которое ничего не принимает и возвращает ничего (void) это действие которое будет выполнено при нажатии на кнопку
    var title: String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline.bold())
                .frame( height: 50)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(Color.primaryBrown)
                .clipShape(RoundedRectangle(cornerRadius: 3))
        }
        .shadow(radius: 3)
    }
}

