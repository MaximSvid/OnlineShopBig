//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AdminHomeView: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Products")
                        .font(.headline)
                    Spacer()
                    
                    Button(action: {
                        productViewModel.addSheet.toggle()
                    }) {
                        Text("Add+")
                            .font(.headline)
                            .clipShape(.buttonBorder)
                    }
                    .shadow(radius: 3)
                }
            }
            .navigationTitle("Admin Home View")
            .padding([.leading, .trailing])
        }
        
    }
}

#Preview {
    AdminHomeView()
        .environmentObject(ProductViewModel())
}
