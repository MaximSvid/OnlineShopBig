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
    //    @State private var currentImageIndex = 0
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                if !product.images.isEmpty {
                    ForEach(product.images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: product.images[index])) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 70, height: 100)
                        }
                        .tag(index)
                    }
                } else {
                    Image("image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .clipped()
                }
            }
            
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
                            .strikethrough(true, color: Color.secondaryGray) // linie
                        
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
            
            Spacer()
            
            VStack {
                Button(action: {
                    userProductViewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: userProductViewModel.favoriteProducts.map { product in
                        product.id ?? ""
                    }
                        .contains(product.id) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.red)
                    .padding()
                }
                .buttonStyle(.plain)
                .padding(2)
                .contentShape(Rectangle())
                
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    
                    Text(String(format: "%.1f", product.rating))
                        .font(.caption)
                }
                .padding(.bottom, 10)
                .padding(.trailing)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(Color.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(radius: 3)
    }
}
