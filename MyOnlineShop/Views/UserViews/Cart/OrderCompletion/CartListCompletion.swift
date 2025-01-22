//
//  CartListCompletion.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.01.25.
//

import SwiftUI

struct CartListCompletion: View {
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
                    
                    Text("One price: ")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondaryGray)
                    
                    if product.action && product.actionPrice > 0.0 {
                        // main price mit linie
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                            .strikethrough(true, color: .gray) // linie
                        
                        // ActionPrice
                        Text(String(format: "€%.2f", product.actionPrice))
                            .font(.caption)
                            .foregroundStyle(.red)
                    } else {
                        // Nur main price
                        Text(String(format: "€%.2f", product.price))
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding(.trailing, 4)
                .padding(.bottom, 4)
                
                // Отображение итоговой цены
                
                HStack {
                    Text("Total price: ")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondaryGray)
                    
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
            }
            
            Spacer()
            
            VStack {
                Spacer()
                    Text("\(userCartViewModel.itemCount[product] ?? 1)")
                        .font(.headline)
                Spacer()
            }
        }
        .frame(width: .infinity, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
    }
}
