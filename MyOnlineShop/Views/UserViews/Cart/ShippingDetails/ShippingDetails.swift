//
//  ShippingDetails.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct ShippingDetails: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State private var countryCode: String = ""
    @State private var phoneNumber: String = ""
    
    @State var country: String = ""
    @State var index: String = ""
    @State var city: String = ""
    @State var street: String = ""
    @State var houseNumber: String = ""
    @State var apartmentNumber: String = ""
    
    @State var deliveryMethod: String = ""

    
    @State var focus: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Personal Details")
                                    .foregroundStyle(.gray.opacity(0.7))
                                Spacer()
                            }
                            CustomTextField(placeholder: "First Name*", text: $firstName)
                            CustomTextField(placeholder: "Last Name*", text: $lastName)
                            CustomTextField(placeholder: "Email*", text: $email)
                            
                            CustomTextFieldPhone(
                                countryCodePlaceholder: "+1",
                                phonePlaceholder: "Phone Number*",
                                countryCode: $countryCode,
                                phoneNumber: $phoneNumber
                            )
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    ContaiterRechtangle {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Adress")
                                    .foregroundStyle(.gray.opacity(0.7))
                                Spacer()
                            }
                            CustomTextField(placeholder: "Country*", text: $country)
                            
                            CustomTextFieldIndexCity(
                                indexPlaceholder: "Index",
                                cityPlaceholder: "City*",
                                index: $index,
                                city: $city
                            )
                        
                        }
                        .padding([.leading, .trailing])
                    }
                    
                    ContaiterRechtangle {
                        HStack {
                            Text("Personal Details")
                                .foregroundStyle(.gray.opacity(0.7))
                            Spacer()
                        }
                    }
                    .padding([.leading, .trailing])
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

#Preview {
    ShippingDetails()
}
