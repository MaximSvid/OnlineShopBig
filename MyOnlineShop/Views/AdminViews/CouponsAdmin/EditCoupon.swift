//
//  EditCoupon.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI

struct EditCoupon: View {
    @EnvironmentObject var couponViewModel: CouponViewModel
    @State private var toast: Toast? = nil
//    var coupon: Coupon
    
//    @State private var couponCode: String = ""
//    @State private var discountType: String = ""
//    @State private var discountValue: Double = 0.0
//    @State private var expirationDate: Date = Date()
//    @State private var isActive: Bool = false
    
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
            
            TextField("Coupon code", text: $couponViewModel.couponeCode)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Picker("Discount Type", selection: $couponViewModel.discountType) {
                Text ("Precentage").tag("precentage")
                Text("Fixed Amount").tag("fixed")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
            HStack {
                Text("Discount Value")
                    .font(.body)
                Spacer()
            }
            
            TextField("Discount Value", value: $couponViewModel.discountValue, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)

            DatePicker("Expitration Date", selection: $couponViewModel.expirationDate, displayedComponents: .date)
                .padding(.bottom)
            
            Toggle("Active", isOn: $couponViewModel.isActive)
                .padding(.bottom)
            
            Button(action: {
                
//                couponViewModel.couponeCode = couponCode
//                couponViewModel.discountType = discountType
//                couponViewModel.discountValue = discountValue
//                couponViewModel.expirationDate = expirationDate
//                couponViewModel.isActive = isActive
                
                if !couponViewModel.couponeCode.isEmpty && !couponViewModel.discountValue.isZero {
                    toast = Toast(style: .success, message: "Coupon updated successfully")
                    couponViewModel.updateCoupon()
                    couponViewModel.updateCouponSheet.toggle()
                } else {
                    toast = Toast(style: .error, message: "Please enter all fields")
                }
                
            }) {
                Text("Update Coupone")
                    .font(.headline.bold())
                    .frame(width: .infinity, height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue.opacity(0.8))
                    .clipShape(.buttonBorder)
            }
            Spacer()
        }
        .padding([.leading, .trailing])
        .toastView(toast: $toast)
//        .onAppear {
//            couponViewModel.setSelectedCoupon(couponViewModel.coupons)
//            couponCode = couponViewModel.couponeCode
//            discountType = couponViewModel.discountType
//            discountValue = couponViewModel.discountValue
//            expirationDate = couponViewModel.expirationDate
//            isActive = couponViewModel.isActive
//        }
    }
}

#Preview {
//    EditCoupon()
}
