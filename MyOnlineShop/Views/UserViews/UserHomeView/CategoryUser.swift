//
//  CategoryUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct CategoryUser: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    @State private var selectedCategory: Categories?
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
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.backgroundColor)
                                .stroke(selectedCategory == category ? Color.primaryBrown : .white, lineWidth: 1)
                        )
                        .shadow(radius: 3)
                        .onTapGesture {
                            userProductViewModel.filterProducts(by: category)
                            selectedCategory = category
                        }
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 2)
            }
        }
    }
}

