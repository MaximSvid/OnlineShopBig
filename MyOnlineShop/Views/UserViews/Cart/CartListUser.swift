//
//  CartListUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI

struct CartListUser: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    var product: Product
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                if !product.images.isEmpty {
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
                    
                } else {
                    Image("image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 100)
                        .cornerRadius(10)
                        .clipped()
                }
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.callout)
                    .padding(.top, 10)
                    .foregroundStyle(.gray)
                
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
                Spacer()
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                        
                    }
                    
                    
                    Text("1")
                        .font(.headline)
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    
                    
                }
                
                Spacer()
            }
            
            
        }
        //        .padding()
        .frame(width: .infinity, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
        
    }
}

#Preview {
    CartListUser( product: Product(title: "Test", price: 123.0))
        .environmentObject(UserViewModel())
}
