//
//  FirebaseService.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//

import FirebaseAuth
import FirebaseFirestore

// Verwaltet die Firebase-Dienste als Singleton
class FirebaseService {
    // Statische Instanz für den Zugriff auf Firebase-Dienste
    static let shared = FirebaseService()
    
    // Privater Initialisierer verhindert weitere Instanzen
    private init() {}
    
    // Authentifizierungsobjekt von Firebase
    let auth: Auth = Auth.auth()
    
    // Datenbankobjekt von Firestore
    let database = Firestore.firestore()
    
    // Gibt die ID des aktuellen Benutzers zurück, falls angemeldet
    var userId: String? {
        auth.currentUser?.uid
    }
}
