//
//  UserProductCard.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct UserProductCard: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    var product: Product
    @State private var isLiked = false
    @State private var currentImageIndex = 0

    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
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
                                    ProgressView()                                        .frame(width: 170, height: 190)
                                }
                                .tag(index)
                            }
                        }
                        .frame(width: 170, height: 190)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
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
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(product.title)
                            .font(.caption)
                        
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption2)

                        
                        Text(String(format: "%.1f", product.rating))
                            .font(.caption2)
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    
                    HStack {
                        Text(product.brand)
                            .font(.caption)
                        
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    
                    HStack {
                        if product.action && product.actionPrice > 0.0 {
                            // main price mit linie
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                                .strikethrough(true, color: .gray) // linie
                            
                            Spacer()
                            
                            // ActionPrice
                            Text(String(format: "€%.2f", product.actionPrice))
                                .font(.caption)
                                .foregroundStyle(.red)
                        } else {
                            // Nur main price
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    .padding(.bottom, 4)
                }

            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                        userProductViewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: userProductViewModel.favoriteProducts.map { product in
                        product.id ?? ""
                    }
                        .contains(product.id) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(product.isFavorite ? .red.opacity(0.8) : .red.opacity(0.8))
                        .padding(8)
                }
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .buttonStyle(BorderedButtonStyle())
            }
        }
        .frame(width: 170, height: 240)
        .background(Color.myBackground)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(radius: 3)
    }
}

