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
                
                Text(String(format: "€%.2f", product.price))
                    .font(.headline)
                    .padding(.bottom, 10)
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
