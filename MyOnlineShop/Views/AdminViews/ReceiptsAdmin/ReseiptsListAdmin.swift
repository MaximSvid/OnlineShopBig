//
//  ReseiptsListAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//

import SwiftUI

struct ReseiptsListAdmin: View {
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
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
                            Color.gray
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
            
            // Секция с информацией о заказе
            VStack(alignment: .leading, spacing: 8) {
                
                // Верхняя строка: статус и дата
                HStack {
                    Text("Status: ")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text(receipt.orderStatus.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(receipt.orderStatus == .processing ? Color.yellow.opacity(0.2) : Color.green.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                    
                    Spacer()
                    
                    Text(receipt.dateCreated.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // Средняя строка: количество товаров и способ доставки
                HStack {
                    Text("\(receipt.products.count) items")
                        .font(.subheadline)
                    
                    Text("•")
                        .foregroundColor(.gray)
                    
                    Text(receipt.deliveryMethod.deliveryName)
                        .font(.subheadline)
                }
                
                // Нижняя строка: итоговая цена
                HStack {
                    Text("Total:")
                        .font(.subheadline)
                    Text("$\(receipt.totalPrice, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .frame(width: .infinity, height: 100)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 3))
        .shadow(radius: 3)
    }
}

#Preview {
//    ReseiptsListAdmin()
}
