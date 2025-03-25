//
//  Category.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.12.24.
//

import SwiftUI

struct Category: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    let categories: [Categories]
    
    var body: some View {
        VStack {
            HStack {
                Text("Categories")
                    .font(.headline)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 10) {
                    ForEach (categories, id: \.self) {category in
                        HStack {
                            Image(systemName: category.icon)
                                .frame(width: 25, height: 25)
                            
                            Text(category.title.capitalized)
                                .font(.caption)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                        )
                        .shadow(radius: 3)
                        .onTapGesture {
                            productViewModel.filterProducts(by: category)
                            
                        }
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 2)
            }
        }
    }
}
