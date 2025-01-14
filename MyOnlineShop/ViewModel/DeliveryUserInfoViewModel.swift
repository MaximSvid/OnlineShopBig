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
    
    
    init(
        deliveryUserInfoRepo: DeliveryUserInfoRepo = DeliveryUserInfoRepoImplementation()
    ) {
        self.deliveryUserInfoRepo = deliveryUserInfoRepo
    }
    
//    func addToDeliveryUserInfo() {
//        
//    }
    
    func addNewDeliveryUserInfo() {
        guard let userId = FirebaseService.shared.userId else { return }
        let newDeliveryUserInfo = DeliveryUserInfo(
            id: nil,
            firstName: firstName,
            lastName: lastName,
            email: email,
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

    
    func observeDeliveryUserInfo() {
//        guard let userId = fb.userId else { return }
//        guard let userId = fb.auth.currentUser?.uid else { return }
        guard let userId = FirebaseService.shared.userId else { return }

        deliveryUserInfoRepo.observeDeliveryUserInfo(userId: userId) { result in
            switch result {
            case .success(let deliveryUserInfo):
                self.deliveryUserInfo = deliveryUserInfo
            case .failure(let error):
                print("Error observing delivery info: \(error.localizedDescription)")
            }
        }
    }
    
    private func resetFields() {
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
    }
    
//    func prepareForEdit(_ deliveryUserInfo: DeliveryUserInfo) {
//        self.selectedDeliveryUserInfo = deliveryUserInfo
//        self.firstName = deliveryUserInfo.firstName
//        self.lastName = deliveryUserInfo.lastName
//        self.email = deliveryUserInfo.email
//        self.phoneNumber = deliveryUserInfo.phoneNumber
//        self.countryCode = deliveryUserInfo.countryCode
//        self.country = deliveryUserInfo.country
//        self.index = deliveryUserInfo.index
//        self.city = deliveryUserInfo.city
//        self.street = deliveryUserInfo.street
//        self.houseNumber = deliveryUserInfo.houseNumber
//        self.apartmentNumber = deliveryUserInfo.apartmentNumber
//    }
//    
//    func updateDeliveryUserInfo() {
//        guard let existionDeliveryUserInfo = selectedDeliveryUserInfo,
//        let deliveryUserInfoId = existionDeliveryUserInfo.id else {
//            print("No deliveryUserInfoId for update")
//            return
//        }
//        let updatedDeliveryUserInfo = DeliveryUserInfo(
//            id: deliveryUserInfoId,
//            firstName: firstName,
//            lastName: lastName,
//            email: email,
//            countryCode: countryCode,
//            phoneNumber: phoneNumber,
//            country: country,
//            index: index,
//            city: city,
//            street: street,
//            houseNumber: houseNumber,
//            apartmentNumber: apartmentNumber
//        )
//        do {
//            try deliveryUserInfoRepo.updateDeliveryUserInfo(deliveryUserInfo: updatedDeliveryUserInfo)
//            print("DeliveryUserInfo updated successfully")
//            //update im local array
//            if let index = deliveryUserInfo.firstIndex(where: { $0.id == deliveryUserInfoId }) {
//                deliveryUserInfo[index] = updatedDeliveryUserInfo
//            }
//        } catch {
//            print("Error updating deliveryUserInfo: \(error)")
//        }
//    }
}
