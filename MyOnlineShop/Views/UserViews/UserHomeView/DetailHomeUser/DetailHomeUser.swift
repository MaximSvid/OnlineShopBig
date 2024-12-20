//
//  DetailHomeUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct DetailHomeUser: View {
    
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
                .padding([.top, .bottom])
                
                HStack {
                    Text(product.brand)
                        .font(.callout)
                        .foregroundStyle(.yellow)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star")
                            .font(.callout)
                        
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
                                //                                        .overlay(
                                //                                            Circle()
                                //                                                .stroke(productViewModel.selectedColor == color ? Color.black : Color.clear, lineWidth: 0.3)
                                //                                        )
                                //                                        .onTapGesture {
                                //                                            productViewModel.selectedColor = color
                                //                                        }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .padding([.top, .bottom])
                
                Text("Desctipton.... asdf;lkjasdf ;klasdf jkl;asdf kjl asdfkljasdf kjl asdfkljasasdfasdf asdf sadf asdf asdf asdf jhksadf lkjas dfkl;jsadf;lk jasdf ;lkjasd f;lkjsadf l;kjas dfklj sadfkjlasdf kl;jdfkl; jasdf;lk asdfljasdf klj lk;adj k;ljasdf jkl kl jasdfkjl;asdfkjlasdf kjl; kjlsadf kjlasdfkljasdf kjl asdk;ljasdfl;jasdf l;asdf kjl;asdf kjl")
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
                    
                    Image(systemName: "heart")
                        .font(.title)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                    
                    
                }
                
                
                
            }
            .padding([.leading, .trailing])
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("HomeDetail Admin")
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
