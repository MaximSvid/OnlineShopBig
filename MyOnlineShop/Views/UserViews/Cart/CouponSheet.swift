//
//  CouponSheet.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI

struct CouponSheet: View {
    @EnvironmentObject var couponUserViewModel: CouponUserViewModel
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    
    var body: some View {
            VStack {
                Text("Enter your Coupo Code")
                    .font(.title)
                    .padding([.top, .bottom])
                
                HStack {
                    Text("Coupon Code")
                        .font(.body)
                    Spacer()
                }
                CustomTextField(placeholder: "Coupone code", text: $couponUserViewModel.couponCode)
                    .padding(.bottom)
                
//                TextField("Coupon code", text: $couponUserViewModel.couponCode)
//                    .textFieldStyle(.roundedBorder)
//                    .padding(.bottom)
                
                if let errorMessage = couponUserViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                
                CustomButtonWithIsLoading(
                    action: {
                        Task {
                            await couponUserViewModel.applyCouponCode(couponUserViewModel.couponCode, to: userCartViewModel.totalSum)
                        }
                    },
                    title: "Apply")
                
//                Button(action: {
//                    Task {
//                        await couponUserViewModel.applyCouponCode(couponUserViewModel.couponCode, to: userCartViewModel.totalSum)
//                    }
//                }) {
//                    if couponUserViewModel.isLoading {
//                        ProgressView()
//                    } else {
//                        Text("Apply")
//                            .font(.headline.bold())
//                            .frame(width: .infinity, height: 50)
//                            .frame(maxWidth: .infinity)
//                            .foregroundStyle(.white)
//                            .background(.blue.opacity(0.8))
//                            .clipShape(.buttonBorder)
//                    }
//                }
                .disabled(couponUserViewModel.couponCode.isEmpty || couponUserViewModel.isLoading) // кнопка неактивна если купон не введен и IsLoading == true
                
                Spacer()
            }
            .padding([.leading, .trailing])
        
    }
}
