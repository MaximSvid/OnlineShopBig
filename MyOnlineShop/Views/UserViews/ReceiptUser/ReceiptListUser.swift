//
//  ReceiptListUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI

struct ReceiptListUser: View {
    @EnvironmentObject var receiptUserViewModel: ReceiptUserViewModel
    var receipt: Receipt
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                
                ForEach(receipt.products) { product in
                    if let firstImage = product.images.first,
                       let url = URLComponents(string: firstImage) {
                        AsyncImage(url: url.url!) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .clipped()
                            
                        } placeholder: {
                            ProgressView()
                                .frame(width: 70, height: 100)
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
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text("Status: ")
                        .font(.caption)
                    
                    Text(receipt.orderStatus.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(receipt.orderStatus.color)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                    
                    Spacer()
                    
                    Text(receipt.dateCreated.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(Color.secondaryGray)
                }
                
                HStack {
                    Text("Delivery: ")
                        .font(.caption)
                        .foregroundColor(Color.secondaryGray)
                    
                    Text(receipt.deliveryMethod.deliveryName)
                        .font(.subheadline)
                    Spacer()
                }
                
                HStack {
                    Text("Total: ")
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryGray)
                    Text("€\(receipt.finalTotalPrice, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(Color.primaryBrown)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .background(Color.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(radius: 3)
    }
}

