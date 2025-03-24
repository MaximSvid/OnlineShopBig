//
//  BannerRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

import SwiftUI
import Firebase

class BannerRepositoryImplementation: BannerRepository {
    
    private let db = Firestore.firestore()
    
    // Fügt ein neues Banner zur Datenbank hinzu
    func addNewBanner(banner: Banner) throws {
        do {
            try db.collection("banners").addDocument(from: banner)
        } catch {
            throw error
        }
    }
    
    // Beobachtet Änderungen an Bannern und gibt sie zurück
    func observeBanner(completion: @escaping (Result<[Banner], any Error>) -> Void) {
        db.collection( "banners").addSnapshotListener { snapshot, error in
            
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            guard let document = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let banners = document.compactMap { document -> Banner? in
                do {
                    return try document.data(as: Banner.self)
                } catch {
                    print(error)
                    return nil
                }
            }
            completion(.success(banners))
        }
    }
    
    // Aktualisiert ein bestehendes Banner in der Datenbank
    func updateBanner(banner: Banner) throws {
        guard let bannerId = banner.id else { return }
        
        do {
            try db.collection("banners").document(bannerId).setData(from: banner)
        } catch {
            throw error
        }
    }
    
}
