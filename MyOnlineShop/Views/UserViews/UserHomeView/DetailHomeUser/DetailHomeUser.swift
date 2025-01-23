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
                                        .clipShape(RoundedRectangle(cornerRadius: 3))
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: .infinity, height: 250)
                                }
                            }
                        }
                        .frame(width: .infinity, height: 250)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // это необходимо чтобы изображение не заходило наверх
                        
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
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                            .clipped()
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text (product.title)
                            .font(.title3.bold())
                    }
                    Spacer()
                    
                    HStack {
                        if product.action && product.actionPrice > 0.0 {
                            // main price mit linie
                            Text(String(format: "€%.2f", product.price))
                                .font(.body)
                                .foregroundStyle(Color.secondaryGray)
                            //                                .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                                .strikethrough(true, color: Color.secondaryGray) // linie
                            
                            // ActionPrice
                            Text(String(format: "€%.2f", product.actionPrice))
                                .font(.caption)
                                .foregroundStyle(.red)
                        } else {
                            // Nur main price
                            Text(String(format: "€%.2f", product.price))
                                .font(.title3)
                            //                                .foregroundStyle(product.isVisible ? .black : .gray)
                        }
                        
                    }
                }
                .padding([.top, .bottom])
                
                
                HStack {
                    Text(product.brand)
                        .font(.subheadline)
                        .foregroundStyle(Color.secondaryGray)
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.callout)
                            .foregroundStyle(.yellow)
                        
                        Text(String(format: "%.1f", product.rating))                       .font(.callout)
                    }
                }
                
                HStack {
                    Text("Quantity of goods:")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondaryGray)
                    
                    Spacer()
                    if product.countProduct > 0 {
                        Text("\(product.countProduct)")
                            .font(.subheadline)
                            .foregroundStyle(product.countProduct <= 10 ? .red : Color.myPrimaryText)
                    } else {
                        Text("Out of stock")
                            .font(.subheadline)
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
                        .foregroundStyle(Color.secondaryGray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ColorEnum.allCases, id: \.self) { color in
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(productViewModel.selectedColor == color ? Color.secondaryGray : Color.clear, lineWidth: 2)
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
                        userCartViewModel.addToCart(for: product)                     }) {
                            Text ("Buy Now")
                                .font(.headline.bold())
                                .frame(width: .infinity, height: 50)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.myPrimaryText)
                                .background(Color.primaryBrown)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
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
                    .background(Color.primaryBrown)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    //                    .padding(2)
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
                            //                                .foregroundStyle(.black)
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
