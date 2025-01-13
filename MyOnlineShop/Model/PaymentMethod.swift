//
//  PaymentMethod.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//
import SwiftUI
import FirebaseFirestore

struct PaymentMethod: Identifiable, Codable {
    @DocumentID var id: String?
    
    var name: String
    var image: String
    var description: String = ""
    var isVisible: Bool 
}
