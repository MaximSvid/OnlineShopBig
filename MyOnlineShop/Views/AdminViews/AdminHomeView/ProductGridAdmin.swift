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
                    Text("Add New Product+")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(Color.primaryBrown)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        
                }
                .shadow(radius: 3)
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(productViewModel.filteredProducts.sorted { $0.isVisible && !$1.isVisible }) { product in
                    NavigationLink (destination: DetailHomeAdmin(product: product)) {
                        AdminProductCard(product: product)
                            .frame(width: 170, height: 240)
                        
                    }
                    
                }
            }
        }
    }
}
