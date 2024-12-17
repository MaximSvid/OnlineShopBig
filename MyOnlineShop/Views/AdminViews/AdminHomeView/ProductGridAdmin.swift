//
//  ProductGrid.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.12.24.
//

import SwiftUI

struct ProductGridAdmin: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    let columns: [GridItem]
    
    var body: some View {
        VStack {
            HStack {
                Text("Products")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    productViewModel.isAddSheetOpen.toggle()
                }) {
                    Text("Add+")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(.blue.opacity(0.8))
                        .clipShape(.buttonBorder)
                }
                .shadow(radius: 3)
            }
            
            LazyVGrid(columns: columns) {
                ForEach(productViewModel.products) { product in
                    NavigationLink (destination: DetailHomeAdmin()) {
                        AdminProductCard(product: product)
                            
                    }
                    
                }
            }
        }
    }
}

#Preview {
//    ProductGrid()
//        .environmentObject(ProductViewModel())
}
