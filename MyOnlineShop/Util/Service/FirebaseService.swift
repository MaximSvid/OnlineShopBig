//
//  FirebaseService.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    
    private init() {}
    
    let auth: Auth = Auth.auth()
    let database = Firestore.firestore()
    
    var userId: String? {
        auth.currentUser?.uid
    }
}
