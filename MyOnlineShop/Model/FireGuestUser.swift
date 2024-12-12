//
//  FireUserGuest.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import Foundation

struct FireGuestUser: Codable, Identifiable {
    var id: String
    var registeredOn: Date = Date()
}
