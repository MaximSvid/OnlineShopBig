//
//  FavoriteListView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct FavoriteListView: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    var product: Product
    var body: some View {
        HStack {
            Image("image")
                .resizable()
                .frame(width: 70, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.leading, 5)
            
            VStack (alignment: .leading) {
                
                Text(product.title)
                    .font(.headline)
                    .padding(.top, 10)
                    
                Spacer()
                Text(product.brand)
                    .font(.caption)
                    
                Spacer()
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
            
            Spacer()
            
            VStack {
                Button(action: {
                    withAnimation(.spring()) {
                        userProductViewModel.toggleFavorite(for: product)
                    }
                }) {
                    Image(systemName: userProductViewModel.favoriteProducts.map { product in
                        product.id ?? ""
                    }
                        .contains(product.id) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(product.isFavorite ? .red : .red)
                        .scaleEffect(product.isFavorite ? 1.3 : 1.0)
                        .padding(8)
                }
                .background(Color.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(2)

                    
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    
                    Text(String(format: "%.1f", product.rating))
                        .font(.caption)
                }
                .padding(.bottom, 10)
            }
            
        }
        .frame(width: .infinity, height: 100)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
        
    }
}

#Preview {
//    FavoriteListView()
//        .environmentObject(UserProductViewModel())
}
