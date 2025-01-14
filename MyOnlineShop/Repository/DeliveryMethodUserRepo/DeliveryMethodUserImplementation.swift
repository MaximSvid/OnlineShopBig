//
//  DeliveryMethodUserImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 14.01.25.
//

import SwiftUI
import Firebase

class DeliveryMethodUserImplementation: DeliveryMethodUserRepo {
    private let db = Firestore.firestore()
    
    func addDeliveryUserMethod(userId: String, deliveryMethod: DeliveryMethod) throws {
        let userDeliveryMethodRef = db.collection("users").document(userId).collection("deliveryMethods").document()
        var data = try Firestore.Encoder().encode(deliveryMethod)
        data["id"] = userDeliveryMethodRef.documentID
        try userDeliveryMethodRef.setData(data)
        
    }
    // Здесь ошибка, тебе не нужен array, тебе нужне только один обект
    func observeDeliveryUserMethods(userId: String, completion: @escaping (Result<[DeliveryMethod], any Error>) -> Void) {
        
    }
    
    
}
