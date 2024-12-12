//
//  FireUserGuest.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import Foundation

struct FireUser: Codable, Identifiable {
    var id: String
    var registeredOn: Date = Date()
    
    var name: String
    var role: UserRole = .user
}

enum UserRole: String, Codable {
    case user
    case admin
}
