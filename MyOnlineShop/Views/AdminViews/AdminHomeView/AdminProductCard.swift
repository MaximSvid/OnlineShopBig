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
                if !product.image.isEmpty {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable()
//                            .scaledToFit()
                            .scaledToFill()
//                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 190)
                            .cornerRadius(12)
                            .clipped()
                            .padding(.horizontal)
                    } placeholder: {
                        Color.gray
                            .frame(width: 170, height: 190)
                    }
                } else {
                    Image("image")
                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
                        .scaledToFill()
                        .frame(width: 170, height: 190)
                        .cornerRadius(12)
                        .clipped()
                }
                
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(product.title)
                            .font(.caption)
                            .foregroundStyle(product.isVisible ? .black : .gray) // isVisible color
                            .fixedSize(horizontal: false, vertical: true)
                        
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
                            .fixedSize(horizontal: false, vertical: true)
                        
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
        .shadow(radius: 3)
    }
}

#Preview {
    //    AdminProductCard()
    //        .environmentObject(ProductViewModel())
}
