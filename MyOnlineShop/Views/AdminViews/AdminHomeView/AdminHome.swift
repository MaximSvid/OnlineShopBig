//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AdminHome: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var bannerViewModel: BannerViewModel
    
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    BannerView()
                    
                    Category(categories: Categories.allCases)
                    
                    ProductGridAdmin(columns: columns)
                    
                    Spacer()
                }
                .navigationTitle("Admin Home View")
                .padding([.leading, .trailing])
                .sheet(isPresented: $productViewModel.isAddSheetOpen) {
                    AddProductSheet()
                        .presentationDragIndicator(.visible)
                    
                }
                .sheet(isPresented: $bannerViewModel.isAddNewBannerOpen) {
                    AddNewBanner()
                        .presentationDragIndicator(.visible)
                }
            }
            .onAppear {
                productViewModel.observeProducts()//herunterladen products aus Firebase
                bannerViewModel.observeBanner()
            }
            
        }
        
    }
}
