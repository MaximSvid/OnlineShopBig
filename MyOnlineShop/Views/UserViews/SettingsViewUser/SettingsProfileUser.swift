//
//  SettingsProfileUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI

struct SettingsProfileUser: View {
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel

    @State private var showError: Bool = false
    @State private var navigateToOrderCompletion: Bool = false


    
    @State var focus: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Personal Details")
                                    
                                Spacer()
                            }
                            CustomTextField(placeholder: "First Name*", text: $deliveryUserInfoViewModel.firstName)
                            CustomTextField(placeholder: "Last Name*", text: $deliveryUserInfoViewModel.lastName)
                            CustomTextField(placeholder: "Email*", text: $deliveryUserInfoViewModel.email)
                            
                            CustomTextFieldPhone(
                                countryCodePlaceholder: "+1",
                                phonePlaceholder: "Phone Number*",
                                countryCode: $deliveryUserInfoViewModel.countryCode,
                                phoneNumber: $deliveryUserInfoViewModel.phoneNumber
                            )
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Adress")
                                    
                                Spacer()
                            }
                            CustomTextField(placeholder: "Country*", text: $deliveryUserInfoViewModel.country)
                            
                            CustomTextFieldIndexCity(
                                indexPlaceholder: "Index",
                                cityPlaceholder: "City*",
                                index: $deliveryUserInfoViewModel.index,
                                city: $deliveryUserInfoViewModel.city
                            )
                            
                            CustomTextFieldStreetHouseCity(
                                streetPlaceholder: "Street*",
                                housePlaceholder: "House*",
                                apartmentPlaceholder: "Apartment",
                                street: $deliveryUserInfoViewModel.street,
                                house: $deliveryUserInfoViewModel.houseNumber,
                                apartment: $deliveryUserInfoViewModel.apartmentNumber
                            )
                            
                            Button(action: {
                                
                            }) {
                                Text("Save")       
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .padding([.leading, .trailing, .top])
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Shipping Details")
                            .font(.title.bold())
                    }
                }
            }
        }
    }
}
