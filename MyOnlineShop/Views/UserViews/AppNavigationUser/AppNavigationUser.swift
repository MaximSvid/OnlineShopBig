//
//  AppNavigationUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 12.12.24.
//

import SwiftUI

struct AppNavigationUser: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                UserHomeView()
            }
            Tab("Settings", systemImage: "gearshape") {
                UserSettingsView()
            }
        }
    }
}

#Preview {
    AppNavigationUser()
}
