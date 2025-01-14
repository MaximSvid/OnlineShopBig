//
//  DeliveryUserInfoRepoImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import Firebase

class DeliveryUserInfoRepoImplementation: DeliveryUserInfoRepo {
    
    private let db = Firestore.firestore()
    
    func addDeliveryUserInfo(userId: String, deliveryInfo: DeliveryUserInfo) throws {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo").document()
        var data = try Firestore.Encoder().encode(deliveryInfo)
        data["id"] = userDeliveryInfoRef.documentID
        try userDeliveryInfoRef.setData(data)
//        do {
//            try userDeliveryInfoRef.setData(data)
//        } catch {
//            throw error
//        }
    }
    
    // Здесь ошибка, тебе не нужен array, тебе нужне только один обект
    func observeDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void) {
        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
        
        userDeliveryInfoRef.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            let deliveryInfos = documents.compactMap { document -> DeliveryUserInfo? in
                try? document.data(as: DeliveryUserInfo.self)
            }
            completion(.success(deliveryInfos))
        }
    }
    
//    func getToDeliveryInfo(userId: String, deliveryInfoId: String, deliveryInfo: String, completion: @escaping (Result<Void, any Error>) -> Void) {
//        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo").document(deliveryInfoId)
//        
//        do {
//            //Эта строка использует встроенный Firestore.Encoder, чтобы преобразовать объект deliveryInfo в формат, который может быть сохранен в Firestore (например, словарь [String: Any]).
//            //    Важно: deliveryInfo должен соответствовать протоколу Encodable (в данном случае String), иначе произойдет ошибка.
//            let data = try Firestore.Encoder().encode(deliveryInfo)
//            
//            //setData(data): Записывает закодированные данные (data) в указанный документ. Если документ существует, данные будут обновлены; если нет, документ создается.
//            //completion(.failure(error)): Если произошла ошибка при записи, она передается через замыкание completion.
//            //    completion(.success(())): Если операция прошла успешно, замыкание возвращает Void.
//            userDeliveryInfoRef.setData(data) { error in
//                if let error {
//                    completion(.failure(error))
//                    return
//                } else {
//                    completion(.success(()))
//                }
//            }
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    //completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void: Замыкание, которое будет вызвано после завершения операции. Оно принимает результат типа Result, который может быть либо успешным (success) с массивом DeliveryUserInfo, либо неудачным (failure) с ошибкой.
//    func loadDeliveryUserInfo(userId: String, completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void) {
//        let userDeliveryInfoRef = db.collection("users").document(userId).collection("userDeliveryInfo")
//        
//        //userDeliveryInfoRef.getDocuments: Асинхронно загружает все документы из подколлекции "userDeliveryInfo".
//        //snapshot, error in: Замыкание, которое вызывается после завершения загрузки. Оно принимает два параметра: snapshot (снапшот данных) и error (ошибка, если она возникла).
//        userDeliveryInfoRef.getDocuments { snapshot, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let documents = snapshot?.documents else {
//                completion(.success([])) // пустой массив, если нет информации про доставку
//                return
//            }
//            //documents.compactMap: Использует метод compactMap для преобразования каждого документа в объект типа DeliveryUserInfo.
//            //            try? doc.data(as: DeliveryUserInfo.self): Пытается декодировать данные документа в объект типа DeliveryUserInfo. Если декодирование не удается, возвращает nil.
//            let deliveryUserInfo = documents.compactMap { doc -> DeliveryUserInfo? in
//                try? doc.data(as: DeliveryUserInfo.self)
//            }
//            completion(.success(deliveryUserInfo))
//        }
//    }
//    
//    
//    
//    
//    func addDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws {
//        do {
//            try db.collection("deliveryUserInfo").addDocument(from: deliveryUserInfo)
//        } catch {
//            throw error
//        }
//    }
//    
//    func observeDeliveryUserInfo(completion: @escaping (Result<[DeliveryUserInfo], any Error>) -> Void) {
//        db.collection("deliveryUserInfo").addSnapshotListener { snapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let documents = snapshot?.documents else {
//                completion(.failure(NSError(domain: "No documents", code: -1)))
//                return
//            }
//            let deliveryUserInfo = documents.compactMap { document -> DeliveryUserInfo? in
//                do {
//                    return try document.data(as: DeliveryUserInfo.self)
//                } catch {
//                    print("Error \(error)")
//                    return nil
//                }
//            }
//            completion(.success(deliveryUserInfo))
//        }
//    }
//    
//    func updateDeliveryUserInfo(deliveryUserInfo: DeliveryUserInfo) throws {
//        guard let diliveryUserInfoId = deliveryUserInfo.id else {
//            throw NSError(domain: "No deliveryUserInfoId", code: -1)
//        }
//        do {
//            try db.collection("deliveryUserInfo").document(diliveryUserInfoId).setData(from: deliveryUserInfo)
//        } catch {
//            throw error
//        }
//    }
}

