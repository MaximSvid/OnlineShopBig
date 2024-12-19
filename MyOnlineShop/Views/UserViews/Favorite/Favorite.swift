//
//  UserFavorite.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 19.12.24.
//

import SwiftUI

struct Favorite: View {
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Favorite")
                        .font(.title.bold())
                }
            }
        }
    }
}

#Preview {
    Favorite()
}
