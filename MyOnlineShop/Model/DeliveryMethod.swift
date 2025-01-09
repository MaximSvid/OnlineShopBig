//
//  Delivery.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//
import SwiftUI
import FirebaseFirestore

struct DeliveryMethod: Identifiable, Codable {
    @DocumentID var id: String? // soll immer optionla sein. am anfang id = nil
    
    var deliveryName: String
    var deliveryPrice: Double
    var deliveryTime: String
}

    
   
