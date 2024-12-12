//
//  SwiftUIView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationAdmin: View {
    var body: some View {
        TabView {
            Tab("Admin Home", systemImage: "house") {
                AdminHomeView()
            }
            Tab("Admin Settings", systemImage: "gear") {
                AdminSettingsView()
            }
        }
    }
}

#Preview {
    AdminHomeView()
}
