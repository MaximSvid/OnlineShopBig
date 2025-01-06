//
//  UserHomeView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct UserHomeView: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var userProductViewModel: UserProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    BannerUserView()
                    
                    CategoryUser(categories: Categories.allCases)
                    ProductGridUser(selectedTab: $selectedTab, columns: columns)
                    
                    
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .onAppear {
                userProductViewModel.observeUserProducts()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Welcome")
                        .font(.title.bold())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bell.fill")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                } 
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        userProductViewModel.isSearchVisible = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .padding(8)
                            .background(Circle().fill(Color.gray.opacity(0.2)))
                    }
                    
                }
            }
            .searchable(
                text: $userProductViewModel.searchText,
                isPresented: $userProductViewModel.isSearchVisible,
                placement: .automatic,
                prompt: "Search products..."
            )
        }
    }
}

#Preview {
//    UserHomeView()
//        .environmentObject(UserProductViewModel())
}
