//
//  ShippingDetails.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct ShippingDetails: View {
    @EnvironmentObject var deliveryUserInfoViewModel: DeliveryUserInfoViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel

    @State private var showError: Bool = false
    @State private var navigateToOrderCompletion: Bool = false
    @Binding var selectedTab: Int

    
//    @State var focus: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Personal Details")
                                    .foregroundStyle(.black.opacity(0.7))
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
                                    .foregroundStyle(.black.opacity(0.7))
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
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Delivery Method")
                                    .foregroundStyle(.black.opacity(0.7))
                                Spacer()
                            }
                            
                            DeliveryMethodSelector()
                            
                            if showError {
                                Text("Please fill in all fields.")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.top, 5)
                            }
                            
                            Button(action: {
                                
                                if !deliveryUserInfoViewModel.firstName.isEmpty && !deliveryUserInfoViewModel.lastName.isEmpty && !deliveryUserInfoViewModel.email.isEmpty &&
                                    !deliveryUserInfoViewModel.phoneNumber.isEmpty &&
                                    !deliveryUserInfoViewModel.country.isEmpty &&
                                    !deliveryUserInfoViewModel.index.isEmpty &&
                                    !deliveryUserInfoViewModel.city.isEmpty &&
                                    !deliveryUserInfoViewModel.street.isEmpty &&
                                    !deliveryUserInfoViewModel.houseNumber.isEmpty &&
                                    deliveryAdminViewModel.selectedDelivery != nil {
                                    navigateToOrderCompletion = true
                                } else {
                                    showError = true
                                }
                                
                            }) {
                                Text("Next")
                                    .font(.headline.bold())
                                    .frame(width: .infinity, height: 50)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.white)
                                    .background(.blue.opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
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
            .navigationDestination(isPresented: $navigateToOrderCompletion) {
                OrderCompletion(selectedTab: $selectedTab)
                    
            }
        }
    }
}

#Preview {
    //    ShippingDetails()
    //        .environmentObject(DeliveryAdminViewModel())
}
