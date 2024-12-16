//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AdminHome: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    Spacer()
                }
                .navigationTitle("Admin Home View")
                .padding([.leading, .trailing])
                .sheet(isPresented: $productViewModel.isAddSheetOpen) {
                    AddProductSheet()
                        .presentationDragIndicator(.visible)
                        
                }
            }
            
        }
        
    }
}

#Preview {
    AdminHome()
        .environmentObject(ProductViewModel())
}
