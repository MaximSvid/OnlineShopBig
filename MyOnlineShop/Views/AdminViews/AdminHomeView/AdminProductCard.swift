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
        @State private var currentImageIndex = 0
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    // Карусель изображений
                    ZStack(alignment: .bottom) {
                        if !product.images.isEmpty {
                            TabView(selection: $currentImageIndex) {
                                ForEach(product.images.indices, id: \.self) { index in
                                    AsyncImage(url: URL(string: product.images[index])) { image in
                                        image.resizable()
                                            .scaledToFill()
                                            .frame(width: 170, height: 190)
                                            .clipShape(RoundedRectangle(cornerRadius: 3))
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()                                            .frame(width: 170, height: 190)
                                    }
                                    .tag(index)
                                }
                            }
                            .frame(width: 170, height: 190)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            // Индикаторы страниц
                            if product.images.count > 1 {
                                HStack(spacing: 6) {
                                    ForEach(0..<product.images.count, id: \.self) { index in
                                        Circle()
                                            .fill(currentImageIndex == index ? Color.white : Color.white.opacity(0.5))
                                            .frame(width: 6, height: 6)
                                    }
                                }
                                .padding(.bottom, 8)
                            }
                        } else {
                            Image("image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 190)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .clipped()
                        }
                    }
                    
                    // Контейнер для текста (оставляем без изменений)
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
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(width: 170)
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
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        productViewModel.deleteProduct(product: product)
                    }) {
                        Image(systemName: "trash")
                            .foregroundStyle(product.isVisible ? .red : .gray)
                            .padding(8)
                    }
                    .background(Color.white.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .padding()
                }
            }
            .frame(width: 170, height: 240)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .shadow(radius: 3)
        }
}
