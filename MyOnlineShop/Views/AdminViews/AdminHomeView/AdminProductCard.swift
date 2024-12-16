//
//  AdminProductCard.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

struct AdminProductCard: View {
    @Environment var productViewModel: ProductViewModel
    var body: some View {
        VStack {
            ZStack {
                HStack {
    //                Toggle ("Visibility", isOn: productViewModel.isVisible)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        
    }
}

#Preview {
//    AdminProductCard()
//        .environmentObject(ProductViewModel())
}
