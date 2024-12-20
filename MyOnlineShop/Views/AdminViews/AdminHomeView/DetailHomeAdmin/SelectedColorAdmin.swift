//
//  SelectedColorAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.12.24.
//

import SwiftUI

//struct SelectedColorAdmin: View {
//    
//    var product: Product
//    @State var selectedColor: ColorEnum = .red
//
//    var body: some View {
//        HStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(ColorEnum.allCases, id: \.self) { color in
//                        Circle()
//                            .fill(color.color)
//                            .frame(width: 30, height: 30)
//                            .overlay(
//                                Circle()
//                                    .stroke(product.selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
//                            )
//                            .onTapGesture {
//                                product.selectedColor = color
//                            }
//                    }
//                }
//                .padding(.horizontal, 8)
//                .padding(.top, 3)
//                .padding(.bottom, 3)
//            }
//        }
//        .padding([.top, .bottom])
//
//    }
//}
//
//#Preview {
//    SelectedColorAdmin()
//}
