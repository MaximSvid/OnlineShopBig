//
//  PriceOrderCompletion.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI

struct PriceOrderCompletion: View {
    @EnvironmentObject var couponUserViewModel: CouponUserViewModel
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    var body: some View {
        HStack {
            Text("Price: ")
                .font(.subheadline)
                .foregroundStyle(Color.secondaryGray)
            Spacer()
            
            
            Text(String(format: "€ %.2f", couponUserViewModel.finalAmount))
                .font(.subheadline)
        }
        .padding(.top)
        
        HStack {
            Text("Delivery price: ")
                .font(.subheadline)
                .foregroundStyle(Color.secondaryGray)
            Spacer()
        
            if let selectedDelivery = deliveryAdminViewModel.selectedDelivery {
                Text(String(format: "€ %.2f", selectedDelivery.deliveryPrice))
                    .font(.subheadline)
                    .foregroundStyle(Color.secondaryGray)
                
            }
        }
        Divider()
        
        HStack {
            Text("Total price: ")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Spacer()
            //эта цена должна сохранятся, как финальная цена заказа в базу данных
            Text(String(format: "€ %.2f", deliveryAdminViewModel.selectedDeliveryPrice + couponUserViewModel.finalAmount))
                .font(.headline)
                .foregroundStyle(couponUserViewModel.appliedCoupon != nil ? .green : .primary)
        }
    }
}

