//
//  ProductGridUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct ProductGridUser: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    @Binding var selectedTab: Int
    
    let columns: [GridItem]
    var body: some View {
        VStack {
            HStack {
                Text("Products")
//                    .font(.headline)
                
                Spacer()
                
                }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(userProductViewModel.filteredProducts.filter { $0.isVisible }) { product in
                    NavigationLink (destination: DetailHomeUser(selectedTab: $selectedTab, product: product)) {
                        UserProductCard(product: product)
                    }
                }
            }
        }
    }
}

#Preview {
//    ProductGridUser()
}
