//
//  DeliveryRepoAdminImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import Firebase

class DeliveryRepoAdminImplementation: DeliveryRepoAdmin {
    
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

    
    func addNewDelivery(delivery: DeliveryMethod) throws {
        do {
            try db.collection("delivery").addDocument(from: delivery)
        } catch {
            throw error
        }
    }
    
    func observeDelivery(completion: @escaping (Result<[DeliveryMethod], any Error>) -> Void) {
        db.collection("delivery").addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "No documents", code: -1)))
                return
            }
            
            let deliveries = documents.compactMap { document -> DeliveryMethod? in
                //compactMap: Преобразует каждый элемент коллекции, но убирает все nil из результата.
                /*
                 1.    documents — массив документов, полученных из Firebase.
                     2.    Для каждого документа применяется замыкание compactMap, где:
                     •    Пытаемся преобразовать document в модель Delivery с помощью функции data(as:).
                     •    Если преобразование удачно, объект Delivery добавляется в массив.
                     •    Если преобразование не удалось (например, данные в документе повреждены или отсутствуют обязательные поля), возвращается nil, и элемент не добавляется в массив.
                     3.    Результат: массив объектов Delivery, где нет nil.
                 */
                do {
                    return try document.data(as: DeliveryMethod.self)
                } catch {
                    print("Error: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(.success(deliveries))
        }
    }
    
    func deleteDelivery(deliveryId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        db.collection("delivery").document(deliveryId).delete { err in
            if let err {
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
/*
 completion — это замыкание, которое принимает один параметр типа Result<Void, any Error> и не возвращает значения (Void). Result — это перечисление, которое может представлять либо успешное завершение операции (success), либо ошибку (failure).
 */
    func updateDelivery(delivery: DeliveryMethod) throws {
        guard let deliveryId = delivery.id else {
            throw NSError(domain: "DeliveryRepoAdminImplementation", code: -1)
        }
        do {
            try db.collection("delivery").document(deliveryId).setData(from: delivery, merge:  true)
        } catch {
            throw error
        }
    }

}
