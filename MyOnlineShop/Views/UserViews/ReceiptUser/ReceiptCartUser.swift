//
//  ReceiptListUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI

struct ReceiptCartUser: View {
    @EnvironmentObject var receiptUserViewModel: ReceiptUserViewModel
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
                    
                    Text("One price: ")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
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
//                .padding(.leading, 4)
                .padding(.bottom, 4)
                
                // Отображение итоговой цены
                
                HStack {
                    Text("Total price: ")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Text(
                        String(
                            format: "€%.2f",
                            product.action && product.actionPrice > 0
                            ? product.actionPrice * Double(receiptUserViewModel.itemCount[product] ?? 1)
                            : product.price * Double(receiptUserViewModel.itemCount[product] ?? 1)
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
                    Text("\(receiptUserViewModel.itemCount[product] ?? 1)")
                        .font(.headline)
                Spacer()
            }
        }
        .frame(width: .infinity, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
    }
}




//#Preview {
//    ReceiptListUser()
//}
