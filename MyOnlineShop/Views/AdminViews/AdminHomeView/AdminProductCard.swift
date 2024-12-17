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
                        Text(String(format: "€%.2f", product.price))
                            .font(.headline)
                            .foregroundStyle(product.isVisible ? .black : .gray)
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
