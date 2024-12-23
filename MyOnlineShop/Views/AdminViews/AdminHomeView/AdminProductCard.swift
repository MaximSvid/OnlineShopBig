//
//  AdminProductCard.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

struct AdminProductCard: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
                   VStack(spacing: 0) {
                       // Изображение
                       if !product.image.isEmpty {
                           AsyncImage(url: URL(string: product.image)) { image in
                               image.resizable()
                                   .scaledToFill()
                                   .frame(width: 170, height: 190)
                                   .cornerRadius(12)
                                   .clipped()
                           } placeholder: {
                               Color.gray
                                   .frame(width: 170, height: 190)
                           }
                       } else {
                           Image("image")
                               .resizable()
                               .scaledToFill()
                               .frame(width: 170, height: 190)
                               .cornerRadius(12)
                               .clipped()
                       }
                       
                       // Контейнер для текста
                       VStack(alignment: .leading, spacing: 4) {
                           // Название и рейтинг
                           HStack {
                               Text(product.title)
                                   .font(.caption)
                                   .foregroundStyle(product.isVisible ? .black : .gray)
                                   .lineLimit(1)
                                   .frame(maxWidth: .infinity, alignment: .leading)
                               
                               HStack(spacing: 2) {
                                   Image(systemName: "star.fill")
                                       .foregroundStyle(product.isVisible ? .yellow : .gray)
                                       .font(.caption2)
                                   
                                   Text(String(format: "%.1f", product.rating))
                                       .font(.caption2)
                                       .foregroundStyle(product.isVisible ? .black : .gray)
                               }
                           }
                           
                           // Бренд
                           Text(product.brand)
                               .font(.caption)
                               .foregroundStyle(product.isVisible ? .black : .gray)
                               .lineLimit(1)
                               .frame(maxWidth: .infinity, alignment: .leading)
                           
                           // Цена
                           HStack {
                               if product.action && product.actionPrice > 0.0 {
                                   Text(String(format: "€%.2f", product.price))
                                       .font(.headline)
                                       .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                                       .strikethrough(true, color: .gray)
                                   
                                   Spacer()
                                   
                                   Text(String(format: "€%.2f", product.actionPrice))
                                       .font(.caption)
                                       .foregroundStyle(.red)
                               } else {
                                   Text(String(format: "€%.2f", product.price))
                                       .font(.headline)
                                       .foregroundStyle(product.isVisible ? .black : .gray)
                                   
                                   Spacer()
                               }
                           }
                           .padding(.bottom, 4)
                       }
                       .padding(.horizontal, 12) // Увеличенный горизонтальный паддинг
                       .padding(.vertical, 8)    // Добавлен вертикальный паддинг
                       .frame(width: 170)        // Фиксированная ширина
                       .background(.white)
                   }
                   
                   // Кнопки управления
                   HStack {
                       Button(action: {
                           productViewModel.toggleVisibility(for: product)
                       }) {
                           Image(systemName: product.isVisible ? "eye" : "eye.slash")
                               .foregroundStyle(product.isVisible ? .blue : .gray)
                               .padding(8)
                       }
                       .background(Color.white.opacity(0.7))
                       .clipShape(RoundedRectangle(cornerRadius: 8))
                       .padding(2)
                       
                       Spacer()
                       
                       Button(action: {
                           productViewModel.deleteProduct(product: product)
                       }) {
                           Image(systemName: "trash")
                               .foregroundStyle(product.isVisible ? .red : .gray)
                               .padding(8)
                       }
                       .background(Color.white.opacity(0.7))
                       .clipShape(RoundedRectangle(cornerRadius: 8))
                       .padding(2)
                   }
               }
               .frame(width: 170, height: 240)
               .background(.white)
               .clipShape(RoundedRectangle(cornerRadius: 8))
               .shadow(radius: 3)    }
}

#Preview {
    //    AdminProductCard()
    //        .environmentObject(ProductViewModel())
}
