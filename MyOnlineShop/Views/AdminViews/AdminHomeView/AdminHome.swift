//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AdminHome: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    ProductGridAdmin(columns: columns)

                    Spacer()
                }
                .navigationTitle("Admin Home View")
                .padding([.leading, .trailing])
                .sheet(isPresented: $productViewModel.isAddSheetOpen) {
                    AddProductSheet()
                        .presentationDragIndicator(.visible)
                        
                }
            }
            .onAppear {
                productViewModel.listenToSnippets()//herunterladen products aus firebase
            }
            
        }
        
    }
}

#Preview {
    AdminHome()
        .environmentObject(ProductViewModel())
}
