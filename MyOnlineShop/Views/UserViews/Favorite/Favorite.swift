//
//  UserFavorite.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct Favorite: View {
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if userProductViewModel.favoriteProducts.isEmpty {
                    Text("You have not added any products to favorite yet")
                        .font(.headline)
                        .foregroundStyle(Color.secondaryGray)
                } else {
                    List (userProductViewModel.favoriteProducts) { product in
                        FavoriteListView(product: product)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Favorite")
                        .font(.title.bold())
                }
            }
            .onAppear {
                userProductViewModel.loadFavorites()
            }
        }
    }
}

