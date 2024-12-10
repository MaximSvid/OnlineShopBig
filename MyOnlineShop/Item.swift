//
//  Item.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 10.12.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
