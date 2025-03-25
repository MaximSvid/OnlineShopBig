//
//  SettingsProfileUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @Environment(\.dismiss) private var dismiss //um eine Anzicht zu machen
    
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
                            
                            CustomMainButton(action: {
                                deliveryUserInfoViewModel.addOrUpdateDeliveryUserInfo()
                                dismiss()
                            }, title: "Save")
                            

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
                .onAppear {
                    
                    if !deliveryUserInfoViewModel.deliveryUserInfo.isEmpty {
                        let firstInfo = deliveryUserInfoViewModel.deliveryUserInfo.first
                        deliveryUserInfoViewModel.prepareForEdit()
                    }
                }

            }
        }
    }
}
