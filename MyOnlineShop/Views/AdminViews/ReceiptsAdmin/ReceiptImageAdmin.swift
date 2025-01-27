//
//  ReceiptListCartDetailAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.01.25.
//

import SwiftUI

struct ReceiptImageAdmin: View {
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
        }
    }
}
    
