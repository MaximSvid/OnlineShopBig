//
//  CouponsAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI

struct CouponsAdmin: View {
//    var coupon: Coupon
    @EnvironmentObject var couponViewModel: CouponViewModel
    var body: some View {
        NavigationStack {
            VStack {
                
                List (couponViewModel.coupons) { coupon in
                    CouponListAdmin(coupon: coupon)
                        .listRowSeparator(.hidden)
//                        .onTapGesture {
//                            couponViewModel.prepareForEdit(coupon)
//                            couponViewModel.updateCouponSheet.toggle()
//                        }
                }
                .listStyle(.plain)                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Coupons")
                        .font(.title.bold())
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button (action: {
                        couponViewModel.couponSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .background(Circle().fill(Color.green))
                            .foregroundStyle(.white)
                    }
                }
            }
            .onAppear {
                couponViewModel.observeCoupons()
            }
            .sheet(isPresented: $couponViewModel.couponSheet) {
                AddNewCoupon()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.8)])
            }
            .sheet(isPresented: $couponViewModel.updateCouponSheet) {
                EditCoupon()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.8)])
            }
        }
    }
}

#Preview {
//    CouponsAdmin()
//        .environmentObject(CouponViewModel())
}
