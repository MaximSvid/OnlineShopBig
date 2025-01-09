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
    private let deliveryUserInfoRepo: DeliveryUserRepo
    
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
        deliveryUserInfoRepo: DeliveryUserRepo = DeliveryUserRepoImplementation()
    ) {
        self.deliveryUserInfoRepo = deliveryUserInfoRepo
    }
    
    func addNewDeliveryUserInfo() {
        let newInfo = DeliveryUserInfo(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            country: country,
            index: index,
            city: city,
            street: street,
            houseNumber: houseNumber
        )
        
        do {
            try deliveryUserInfoRepo.addDeliveryUserInfo(deliveryUserInfo: newInfo)
            print("Delivery user info added successfully")
            resetFields()
        } catch {
            print("Error adding new delivery user info: \(error.localizedDescription)")
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
    }
    
}
