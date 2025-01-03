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
    @State private var currentImageIndex = 0
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                if !product.images.isEmpty {
                    TabView(selection: $currentImageIndex) {
                        ForEach(product.images.indices, id: \.self) { index in
                            AsyncImage(url: URL(string: product.images[index])) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 100)
                                    .cornerRadius(10)
                                    .clipped()
                            } placeholder: {
                                Color.gray
                                    .frame(width: 70, height: 100)
                            }
                            .tag(index)
                        }
                    }
                    .frame(width: 70, height: 100)
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
                        .frame(width: 70, height: 100)
                        .cornerRadius(10)
                        .clipped()
                }
            }
//            .padding(.leading)
            
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
                    userProductViewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: userProductViewModel.favoriteProducts.map { product in
                        product.id ?? ""
                    }
                        .contains(product.id) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(product.isFavorite ? .red : .red)
                    .padding()
                }
                .buttonStyle(.plain)
//                .background(Color.white.opacity(0.7))
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
