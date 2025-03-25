//
//  CartListUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI

struct CartListUser: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    @EnvironmentObject var userCartViewModel: UserCartViewModel
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
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.callout)
                    .padding(.top, 10)
                    .foregroundStyle(Color.secondaryGray)
                
                Spacer()
                
                HStack {
                    
                    
                    if product.action && product.actionPrice > 0.0 {
                        // main price mit linie
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                            .strikethrough(true, color: .gray) // linie
                    
                        Text(String(format: "€%.2f", product.actionPrice))
                            .font(.caption)
                            .foregroundStyle(.red)
                    } else {
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)

                    }
                    Spacer()
                    
                    
                }
                .padding(.trailing, 4)
                .padding(.leading, 4)
                .padding(.bottom, 4)
            
                Text(
                    String(
                        format: "€%.2f",
                        product.action && product.actionPrice > 0
                        ? product.actionPrice * Double(userCartViewModel.itemCount[product] ?? 1)
                        : product.price * Double(userCartViewModel.itemCount[product] ?? 1)
                    )
                )
                .font(.headline)
                Spacer()
                
                
            }
            
            Spacer()
            
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        userCartViewModel.updateCountProducts(for: product, increment: false)
                    }) {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.backgroundColor)
                            .background(Color.primaryBrown)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    .buttonStyle(.plain)
                    
                    
                    Text("\(userCartViewModel.itemCount[product] ?? 1)")
                        .font(.headline)
                    
                    Button(action: {
                        userCartViewModel.updateCountProducts(for: product, increment: true)
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.backgroundColor)
                            .background(Color.primaryBrown)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(radius: 3)
        
    }
}

#Preview {
    CartListUser( product: Product(title: "Test", price: 123.0))
        .environmentObject(UserViewModel())
        .environmentObject(UserCartViewModel())
}
