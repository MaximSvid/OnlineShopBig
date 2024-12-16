//
//  Extension.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

import SwiftUI

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
