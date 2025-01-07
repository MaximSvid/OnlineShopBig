//
//  CouponRepositoryUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

protocol CouponRepositoryUser {
    func validateCoupon(code: String) async throws -> Coupon
    func applyCoupon(coupon: Coupon, to amount: Double) -> Double
}
