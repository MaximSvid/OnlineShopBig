//
//  BunnerImage.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//
import SwiftUI
import FirebaseFirestore

struct Banner: Codable, Identifiable {
    @DocumentID var id: String?
    
    var bannerName: String
    var bannerImage: [String] = []
}
