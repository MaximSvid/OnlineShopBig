//
//  CouponError.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import Foundation

enum CouponError: LocalizedError {
    case invalidCoupon
    case expired
    case alreadyUsed
    
    var errorDescription: String? {
        switch self {
        case .invalidCoupon:
            return "Invalid coupon"
        case .expired:
            return "Coupon expired"
        case .alreadyUsed:
            return "Coupon already used"
        }
    }
}
