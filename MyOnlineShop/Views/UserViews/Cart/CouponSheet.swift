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
            .disabled(couponUserViewModel.couponCode.isEmpty || couponUserViewModel.isLoading)//button inactive when couponCode.isEmpty und couponUserViewModel.isLoading
            
            Spacer()
        }
        .padding([.leading, .trailing])
        
    }
}
