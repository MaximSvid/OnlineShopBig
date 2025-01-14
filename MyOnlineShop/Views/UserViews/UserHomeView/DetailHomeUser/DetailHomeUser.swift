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
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    @Binding var selectedTab: Int
    var product: Product
    @State private var currentImageIndex = 0
    
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                ZStack(alignment: .bottom) {
                    if !product.images.isEmpty {
                        TabView(selection: $currentImageIndex) {
                            ForEach(product.images.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: product.images[index])) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: .infinity, height: 250)
                                        .cornerRadius(12)
                                        .clipped()
                                } placeholder: {
                                    Color.gray
                                        .frame(width: .infinity, height: 250)
                                }
                                .tag(index)
                            }
                        }
                        .frame(width: .infinity, height: 250)
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
                            .frame(width: .infinity, height: 250)
                            .cornerRadius(12)
                            .clipped()
                    }
                }
                
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
                }
                .padding([.top, .bottom])
                
                
                HStack {
                    Text(product.brand)
                        .font(.callout)
                    
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.callout)
                            .foregroundStyle(.yellow)
                        
                        Text(String(format: "%.1f", product.rating))                            .font(.callout)
                    }
                }
                
                HStack {
                    Text("Quantity of goods:")
                        .font(.callout)
                    
                    Spacer()
                    if product.countProduct > 0 {
                        Text("\(product.countProduct)")
                            .font(.callout)
                            .foregroundStyle(product.countProduct <= 10 ? .red : .primary)
                    } else {
                        Text("Out of stock")
                            .font(.callout)
                            .foregroundStyle(.red)
                            .onAppear {
                                productViewModel.toggleVisibility(for: product)
                            }
                    }
                }
                .padding(.top, 3)
                .padding(.bottom, 3)
                
                HStack {
                    Text("Select a  Color")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
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
                        userCartViewModel.addToCart(for: product) //при нажатии на кнопку товары добавляются в базу данных, а нужно чтобы они просто локально отображались в cartListUser
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
            .onAppear {
                userCartViewModel.loadCart() 
            }
            .padding([.leading, .trailing])
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Detail View")
                        .font(.title.bold())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        selectedTab = 1 // Переключаемся на вкладку корзины
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.headline)
                                .foregroundStyle(.gray)
                                .padding(8)
                                .background(Circle().fill(Color.gray.opacity(0.2)))
                            
                            if userCartViewModel.cartItemsCount > 0 {
                                Text("\(userCartViewModel.cartItemsCount)")
                                    .font(.caption2)
                                    .padding(5)
                                    .foregroundStyle(.white)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -4)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    //    DetailHomeUser()
}
