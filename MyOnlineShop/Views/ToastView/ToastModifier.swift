//
//  ToastModifier.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI
    // не использую

struct ToastModifier: View {
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
//    ToastModifier()
}
