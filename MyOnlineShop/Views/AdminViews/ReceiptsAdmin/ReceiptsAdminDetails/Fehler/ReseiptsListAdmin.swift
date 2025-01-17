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
            
            // Секция с информацией о заказе
            VStack(alignment: .leading, spacing: 8) {
                
                // Верхняя строка: статус и дата
                HStack {
                    Text("Status: ")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
//                    StatusAdmin()
//                    Text(receipt.orderStatus.rawValue)
//                        .font(.caption)
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 4)
//                        .background(receipt.orderStatus == .processing ? Color.yellow.opacity(0.2) : Color.green.opacity(0.2))
//                        .clipShape(RoundedRectangle(cornerRadius: 3))
                    
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
