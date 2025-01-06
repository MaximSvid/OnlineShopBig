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
                            .font(.subheadline)
                            .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                            .strikethrough(true, color: .gray) // linie
                        
//                        Spacer()
                        
                        // ActionPrice
                        Text(String(format: "€%.2f", product.actionPrice))
                            .font(.caption)
                            .foregroundStyle(.red)
                    } else {
                        // Nur main price
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                            .foregroundStyle(product.isVisible ? .black : .gray)
                    }
                    Spacer()
                    
                    
                }
                .padding(.trailing, 4)
                .padding(.leading, 4)
                .padding(.bottom, 4)
                
                // Отображение итоговой цены
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
                        //increment false - Это значит уменьшается
                    }) {
                        Image(systemName: "minus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    .buttonStyle(.plain)// этот атрибут необходим, чтобы экранировать list и нажимались только кнопки
                    
                    
                    Text("\(userCartViewModel.itemCount[product] ?? 1)")
                        .font(.headline)
                    
                    Button(action: {
                        userCartViewModel.updateCountProducts(for: product, increment: true)
                        //increment true - Это значит увеличивается
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                    .buttonStyle(.plain)
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
        .environmentObject(UserCartViewModel())
}
