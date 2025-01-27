//
//  AppNavigationUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationUser: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    @EnvironmentObject var receiptsUserViewModel: ReceiptUserViewModel
    
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            UserHomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            CartUser(selectedTab: $selectedTab)
                .tabItem {
                    Label("My Cart", systemImage: "cart")
                }
                .badge(userCartViewModel.cartItemsCount) // отвечает за отображение количество товара в корзине 
                .tag(1)
            
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "star")
                }
                .badge(userProductViewModel.favoriteCount()) // anzahl Poducten im favorite
                .tag(2)
            
            ReceiptUser()
                .tabItem {
                    Label("Receipts", systemImage: "list.clipboard")
                }
                .badge(receiptsUserViewModel.receiptsCount())
                .tag(4)

            
            UserSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(5)
        }
        .tint(Color.primaryBrown)
    }
}


#Preview {
    AppNavigationUser()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
}
