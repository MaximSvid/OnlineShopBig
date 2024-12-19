//
//  UserHomeView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct UserHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Category(categories: Categories.allCases)
                    
                    
                    Spacer()
                }
                .padding([.leading, .trailing])
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
                    Image(systemName: "magnifyingglass")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
            }
        }
    }
}

#Preview {
    UserHomeView()
}
