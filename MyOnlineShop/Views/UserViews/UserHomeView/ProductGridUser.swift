//
//  ProductGridUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct ProductGridUser: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    
    let columns: [GridItem]
    var body: some View {
        VStack {
            HStack {
                Text("Products")
                    .font(.headline)
                
                Spacer()
                
                }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(userProductViewModel.filteredProducts.sorted { $0.isVisible && !$1.isVisible }) { product in
                    NavigationLink (destination: DetailHomeUser()) {
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
