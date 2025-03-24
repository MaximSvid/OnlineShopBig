//
//  DeliveryUserInfoViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 09.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class DeliveryUserInfoViewModel: ObservableObject {
    @Published var deliveryUserInfo: [DeliveryUserInfo] = []
    @Published var selectedDeliveryUserInfo: DeliveryUserInfo?
    
    private let fb = FirebaseService.shared
    private let deliveryUserInfoRepo: DeliveryUserInfoRepo
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    
    @Published var countryCode: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var country: String = ""
    @Published var index: String = ""
    @Published var city: String = ""
    @Published var street: String = ""
    @Published var houseNumber: String = ""
    @Published var apartmentNumber: String = ""
    
    // Initialisiert das ViewModel mit einem DeliveryUserInfo-Repository
    init(
        deliveryUserInfoRepo: DeliveryUserInfoRepo = DeliveryUserInfoRepoImplementation()
    ) {
        self.deliveryUserInfoRepo = deliveryUserInfoRepo
        // Stellt sicher, dass die Lieferdaten für den aktuellen Benutzer korrekt geladen werden
        fb.auth.addStateDidChangeListener { auth, user  in
            guard user != nil else { return }
            self.observeDeliveryUserInfo()
        }
    }
    
    // Fügt neue Lieferinformationen für den Benutzer hinzu
    func addNewDeliveryUserInfo() {
        guard let userId = FirebaseService.shared.userId else { return }
        let newDeliveryUserInfo = DeliveryUserInfo(
            id: nil,
            firstName: firstName,
            lastName: lastName,
            email: email,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            country: country,
            index: index,
            city: city,
            street: street,
            houseNumber: houseNumber,
            apartmentNumber: apartmentNumber
        )
        
        do {
            try deliveryUserInfoRepo.addDeliveryUserInfo(userId: userId, deliveryInfo: newDeliveryUserInfo)
            print("Delivery user info added successfully")
            resetFields()
        } catch {
            print("Error adding new delivery user info: \(error.localizedDescription)")
        }
    }
    
    // Beobachtet Änderungen an den Lieferinformationen des Benutzers
    func observeDeliveryUserInfo() {
        guard let userId = FirebaseService.shared.userId else { return }
        
        deliveryUserInfoRepo.observeDeliveryUserInfo(userId: userId) { result in
            switch result {
            case .success(let deliveryUserInfo):
                self.deliveryUserInfo = deliveryUserInfo
                print("Success observing delivery user info")
            case .failure(let error):
                print("Error observing delivery info: \(error.localizedDescription)")
            }
        }
    }
    
    // Setzt die Eingabefelder zurück
     func resetFields() {
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
        countryCode = ""
        country = ""
        index = ""
        city = ""
        street = ""
        houseNumber = ""
        apartmentNumber = ""
         deliveryUserInfo = []
    }
    
    // Entfernt alle Lieferinformationen des Benutzers
    func deleteDeliveryUserInfoFromUser() async {
        guard let userId = FirebaseService.shared.userId else { return }
        do {
            try await deliveryUserInfoRepo.deleteDeliveryUserInfoFromUser(userId: userId)
        } catch {
            print("Error delete deliveryUserInfo")
        }
    }
    
    // Bereitet Lieferinformationen für die Bearbeitung vor
    func prepareForEdit() {
        guard let deliveryUserInfo = self.deliveryUserInfo.first else { return }
        
        self.selectedDeliveryUserInfo = deliveryUserInfo
        
        self.firstName = deliveryUserInfo.firstName
        self.lastName = deliveryUserInfo.lastName
        self.email = deliveryUserInfo.email
        
        self.countryCode = deliveryUserInfo.countryCode
        self.phoneNumber = deliveryUserInfo.phoneNumber
        
        self.country = deliveryUserInfo.country
        self.index = deliveryUserInfo.index
        self.city = deliveryUserInfo.city
        self.street = deliveryUserInfo.street
        self.houseNumber = deliveryUserInfo.houseNumber
        self.apartmentNumber = deliveryUserInfo.apartmentNumber
        
    }
    
    // Aktualisiert die Lieferinformationen des Benutzers
    func updateDeliveryUserInfo() {
        guard let deliveryUserInfo = selectedDeliveryUserInfo,
              let deliveryUserInfoId = deliveryUserInfo.id else {
            print("No deliveryUserInfo")
            return
        }
        let updatedDeliveryUserInfo = DeliveryUserInfo(
            id: deliveryUserInfoId,
            firstName: firstName,
            lastName: lastName,
            email: email,
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            country: country,
            index: index,
            city: city,
            street: street,
            houseNumber: houseNumber,
            apartmentNumber: apartmentNumber
        )
        do {
            try deliveryUserInfoRepo.updateUserInfo(newDeliveryUserInfo: updatedDeliveryUserInfo)
            print("DeliveryUserInfo updated successfully")
            if let index = self.deliveryUserInfo.firstIndex(where: { $0.id == deliveryUserInfoId }) {
                self.deliveryUserInfo[index] = updatedDeliveryUserInfo
            }
        } catch {
            print("Error updating deliveryUserInfo: \(error)")
        }
    }
    
    // Fügt neue oder aktualisiert vorhandene Lieferinformationen
    func addOrUpdateDeliveryUserInfo () {
        guard let userId = FirebaseService.shared.userId else { return }
        
        deliveryUserInfoRepo.checkIfDeliveryUserInfoExists(userId: userId) { exists in
            if exists {
                self.updateDeliveryUserInfo()
            } else {
                self.addNewDeliveryUserInfo()
            }
        }
    }
}
