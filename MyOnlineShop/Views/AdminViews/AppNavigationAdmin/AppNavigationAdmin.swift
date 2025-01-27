//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationAdmin: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var receiptAdminViewModel: ReceiptAdminViewModel
    
    var body: some View {
        TabView {
            Tab("Admin Home", systemImage: "house") {
                AdminHome()
            }

            Tab("Receipts", systemImage: "list.clipboard") {
                AdminReceipts()
            }
            .badge(receiptAdminViewModel.receiptsCount())

            Tab("Other Items", systemImage: "rectangle.and.pencil.and.ellipsis") {
                OtherItems()
            }
        }
        .tint(Color.primaryBrown)
    }
}

#Preview {
    AdminHome()
        .environmentObject(AuthViewModel(userViewModel: UserViewModel()))
}
