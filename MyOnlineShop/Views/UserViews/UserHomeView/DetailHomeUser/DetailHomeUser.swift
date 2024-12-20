//
//  DetailHomeUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct DetailHomeUser: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    var product: Product
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                Image("image")
                    .resizable()
                    .frame(width: .infinity, height: 250)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text (product.title)
                            .font(.headline.bold())
                        
                    }
                    Spacer()
                    
                    HStack {
                        if product.action && product.actionPrice > 0.0 {
                            // main price mit linie
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                                .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                                .strikethrough(true, color: .gray) // linie
                            
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
                        
                    }
                    .padding([.top, .bottom])
                }
                
                HStack {
                    Text(product.brand)
                        .font(.callout)
                        .foregroundStyle(.yellow)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.callout)
                            .foregroundStyle(.yellow)
                        
                        Text(String(format: "%.1f", product.rating))                            .font(.callout)
                    }
                }
                
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ColorEnum.allCases, id: \.self) { color in
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(productViewModel.selectedColor == color ? Color.gray : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        productViewModel.selectedColor = color
                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                    }
                }
                .padding([.top, .bottom])
                
                Text(product.description)
                    .font(.footnote)
                    .padding([.top, .bottom])
                
                Spacer()
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Text ("Buy Now")
                            .font(.headline.bold())
                            .frame(width: .infinity, height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(.blue.opacity(0.8))
                            .clipShape(.buttonBorder)
                    }
                    .shadow(radius: 3)
                    
                    Spacer()
                    
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
                    .buttonStyle(BorderedButtonStyle())
                }
            }
            .padding([.leading, .trailing])
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Detail View")
                        .font(.title.bold())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "cart")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
            }
        }
    }
}

#Preview {
    //    DetailHomeUser()
}
