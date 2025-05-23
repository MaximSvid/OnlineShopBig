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
    
    @Published var errorMessage: String?
    @Published var isError: Bool = false

    // Initialisiert das ViewModel mit einem Delivery-Repository
    init(
        deliveryRepository: DeliveryRepoAdmin = DeliveryRepoAdminImplementation()
    ) {
        self.deliveryRepository = deliveryRepository
    }
    
    // Fügt eine Versandmethode für den Benutzer hinzu
    func addUserDeliveryMethod() {
        guard let userId = FirebaseService.shared.userId else { return }
        let deliveryMethod = DeliveryMethod(
            id: nil,
            deliveryName: selectedDelivery?.deliveryName ?? "",
            deliveryPrice: selectedDelivery?.deliveryPrice ?? 0.0,
            deliveryTime: selectedDelivery?.deliveryTime ?? ""
        )
        do {
            try deliveryRepository.addDeliveryUserMethod(userId: userId, deliveryMethod: deliveryMethod)
            print("Delivery method addad succecfully")
        } catch {
            print("Error adding delivery method: \(error.localizedDescription)")
        }
    }
    
    // Fügt eine neue Versandmethode hinzu
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
    
    // Setzt die Eingabefelder zurück
    private func resetFields() {
        deliveryName = ""
        deliveryPrice = 0.0
        deliveryTime = ""
    }
    
    // Beobachtet Änderungen an Versandmethoden
    func observeDeliveries() {
        deliveryRepository.observeDelivery { deliveries in
            switch deliveries {
            case .success(let deliveries):
                self.deliveries = deliveries
                
            case .failure(let error):
                print("Error observing deliveries: \(error.localizedDescription)")
            }
        }
    }
    
    // Entfernt eine Versandmethode
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
    
    // Bereitet eine Versandmethode für die Bearbeitung vor
    func prepareForEdit(_ delivery: DeliveryMethod) {
        self.selectedDelivery = delivery
        self.deliveryName = delivery.deliveryName
        self.deliveryPrice = delivery.deliveryPrice
        self.deliveryTime = delivery.deliveryTime
    }
    
    // Aktualisiert eine bestehende Versandmethode
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
            if let index = deliveries.firstIndex(where: { $0.id == deliveryId }) {
                deliveries[index] = updateDelivery
            }
            sheetEditDelivery.toggle()
        } catch {
            print("Error updating delivery: \(error.localizedDescription)")
        }
    }
    
    // Gibt den Preis der ausgewählten Versandmethode zurück
    var selectedDeliveryPrice: Double  {
        if let selectedDelivery = deliveries.first(where: { $0.id == selectedDelivery?.id }) {
            return selectedDelivery.deliveryPrice
        }
        return 0.0
    }
    
    // Entfernt alle Versandmethoden eines Benutzers
    func deleteDeliveryFormUser() async {
        guard let userId = FirebaseService.shared.userId else { return }
        do {
            try await deliveryRepository.deleteDeliveryFromUser(userId: userId)
            print("Delivery deleted")
        } catch {
            print("Error deleting delivery: \(error.localizedDescription)")
        }
    }
    
}



