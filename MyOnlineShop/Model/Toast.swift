//
//  Toast.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//
import SwiftUI
struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
}
