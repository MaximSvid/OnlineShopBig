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
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 180)
                    .clipped()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(product.title)
                            .font(.caption)
                            .foregroundStyle(product.isVisible ? .black : .gray) // isVisible color
                        
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundStyle(product.isVisible ? .yellow : .gray)
                            .font(.caption2)

                        
                        Text(String(format: "%.1f", product.rating))
                            .font(.caption2)
                            .foregroundStyle(product.isVisible ? .black : .gray)
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    
                    HStack {
                        Text(product.brand)
                            .font(.caption)
                            .foregroundStyle(product.isVisible ? .black : .gray)
                        
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    
                    HStack {
                        if product.action && product.actionPrice > 0.0 {
                            // main price mit linie
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                                .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
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
                                .foregroundStyle(product.isVisible ? .black : .gray)
                        }
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    .padding(.leading, 4)
                    .padding(.bottom, 4)
                }
                .background(.white)
            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        userProductViewModel.toggleFavorite(for: product)
//                        userProductViewModel.isLiked.toggle()
                    }
                }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
//                        .foregroundStyle(product.isVisible ? .red : .gray)
                        .foregroundStyle(product.isFavorite ? .red : .gray)
                        .scaleEffect(product.isFavorite ? 1.3 : 1.0)
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
        .shadow(radius: 3)
    }
}

#Preview {
//    UserProductCard()
}
