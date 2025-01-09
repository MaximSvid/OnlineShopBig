//
//  DeliveryAdminViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class DeliveryAdminViewModel: ObservableObject {
    
    @Published var deliveries: [DeliveryMethod] = []
    @Published var selectedDelivery: DeliveryMethod?
    
    @Published var deliveryName: String = ""
    @Published var deliveryPrice: Double = 0
    @Published var deliveryTime: String = ""
    
    @Published var sheetEditDelivery: Bool = false
    @Published var sheetAddDelivery: Bool = false
    
    private let fb = FirebaseService.shared
    private let deliveryRepository: DeliveryRepoAdmin
    
    init(
        deliveryRepository: DeliveryRepoAdmin = DeliveryRepoAdminImplementation()
    ) {
        self.deliveryRepository = deliveryRepository
    }
    
    func addNewDelivery() {
        let newDelivery = DeliveryMethod(
            deliveryName: deliveryName,
            deliveryPrice: deliveryPrice,
            deliveryTime: deliveryTime
        )
        do {
            try deliveryRepository.addNewDelivery(delivery: newDelivery)
            print("Delivery added successfully: \(newDelivery.deliveryName)")
            resetFields()
            sheetAddDelivery.toggle()
        } catch {
            print("Error adding new delivery: \(error.localizedDescription)")
        }
    }
    
    private func resetFields() {
        deliveryName = ""
        deliveryPrice = 0.0
        deliveryTime = ""
    }
    
    func observeDeliveries() {
        deliveryRepository.observeDelivery { deliveries in
            switch deliveries {
            case .success(let deliveries):
                self.deliveries = deliveries
                
            case .failure(let error):
                print("Error observing deliveries: \(error.localizedDescription)")
                /*
                 Используйте localizedDescription, когда вам нужно показать пользователю понятное сообщение об ошибке. Для логирования и отладки используйте более технические описания ошибок, такие как debugDescription или description.
                 */
            }
        }
    }
    
    func deleteDelivery(delivery: DeliveryMethod) {
        guard let deliveryId = delivery.id else {
            print("Error deleting delivery: deliveryId is nil")
            return
        }
        deliveryRepository.deleteDelivery(deliveryId: deliveryId) { result in
            switch result {
            case .success:
                if let index = self.deliveries.firstIndex(where: { $0.id == deliveryId }) {
                    self.deliveries.remove(at: index)
                }
                print("Delivery deleted successfully")
            case .failure(let error):
                print("Error deleting delivery: \(error.localizedDescription)")
            }
        }
    }
    
    func prepareForEdit(_ delivery: DeliveryMethod) {
        self.selectedDelivery = delivery
        self.deliveryName = delivery.deliveryName
        self.deliveryPrice = delivery.deliveryPrice
        self.deliveryTime = delivery.deliveryTime
    }
    
    func updateDelivery() {
        guard let existingDelivery = selectedDelivery,
              let deliveryId = existingDelivery.id else {
            print("Error updating delivery: deliveryId is nil")
            return
        }
        let updateDelivery = DeliveryMethod(
            id: deliveryId,
            deliveryName: deliveryName,
            deliveryPrice: deliveryPrice,
            deliveryTime: deliveryTime
        )
        do {
            try deliveryRepository.updateDelivery(delivery: updateDelivery)
            print("Delivery updated successfully")
            // Обновляем купон в локальном массиве
            if let index = deliveries.firstIndex(where: { $0.id == deliveryId }) {
                deliveries[index] = updateDelivery
            }
            sheetEditDelivery.toggle()
        } catch {
            print("Error updating delivery: \(error.localizedDescription)")
        }
    }
}

