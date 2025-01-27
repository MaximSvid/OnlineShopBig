//
//  AddNewCoupon.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI

struct AddNewCoupon: View {
    @EnvironmentObject var couponViewModel: CouponViewModel
    @State private var errorMessage: Bool = false
//
    var body: some View {
        
        VStack {
            Text("Add New Coupon")
                .font(.title)
                .padding([.top, .bottom])
            
            HStack {
                Text("Coupon Code")
                    .font(.body)
                Spacer()
            }
            CustomTextField(placeholder: "Coupon code", text: $couponViewModel.couponeCode)
            
            Picker("Discount Type", selection: $couponViewModel.discountType) {
                Text ("Precentage").tag("percentage")
                Text("Fixed Amount").tag("fixed")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.bottom, .top])
            
            HStack {
                Text("Discount Value")
                    .font(.body)
                Spacer()
            }
            
            CustomNumberDoubleField(placeholder: "Discount Value", value: $couponViewModel.discountValue)
            
            DatePicker("Expitration Date", selection: $couponViewModel.expirationDate, displayedComponents: .date)
                .padding(.bottom)
            
            Toggle("Active", isOn: $couponViewModel.isActive)
                .padding(.bottom)
            
            if errorMessage {
                Text("Please fill all fields")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            Button(action: {
                if !couponViewModel.couponeCode.isEmpty && !couponViewModel.discountValue.isZero && !couponViewModel.discountType.isEmpty {
                    couponViewModel.addNewCoupon()
                    couponViewModel.couponSheet.toggle()
                } else {
                    errorMessage = true
                }
                
            }) {
                Text("Add Coupon Code")
                    .font(.headline.bold())
                    .frame(width: .infinity, height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color.primaryBrown)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddNewCoupon()
        .environmentObject(CouponViewModel())
}
