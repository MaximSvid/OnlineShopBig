//
//  CouponUserViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class CouponUserViewModel: ObservableObject {
    
    @Published var couponSheet: Bool = false
    @Published var couponCode: String = ""
    
    @Published var finalAmount: Double = 0.0
    
    @Published var appliedCoupon: Coupon?
    @Published var discountedAmount: Double?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    
    private let couponRepositoryUser: CouponRepositoryUser
    
    init(couponRepositoryUser: CouponRepositoryUser = CouponRepositoryUserImplementation()) {
        self.couponRepositoryUser = couponRepositoryUser
    }
    
    func applyCouponCode(_ code: String, to amount: Double) async{
        isLoading = true
        errorMessage = nil
        
        do {
            let coupon = try  await couponRepositoryUser.validateCoupon(code: code)
            let calculatedAmount  =  couponRepositoryUser.applyCoupon(coupon: coupon, to: amount)
            
            appliedCoupon = coupon
            discountedAmount = calculatedAmount
            finalAmount = calculatedAmount
            couponSheet.toggle()
            couponCode = ""
            print("Coupon applied")
            
        } catch CouponError.invalidCoupon {
            errorMessage = "Invalid coupon code. Please check and try again."
            appliedCoupon = nil
            discountedAmount = nil
        } catch CouponError.expired {
            errorMessage = "This coupon has expired."
            appliedCoupon = nil
            discountedAmount = nil
        } catch {
            errorMessage = "An error occurred. Please try again later."
            appliedCoupon = nil
            discountedAmount = nil
        }
        isLoading = false
    }
    
    func updateFinalAmount(totalSum: Double) {
        if let coupon = appliedCoupon {
            // Пересчитываем скидку при изменении общей суммы
            let newAmount = couponRepositoryUser.applyCoupon(coupon: coupon, to: totalSum)
            discountedAmount = newAmount
            finalAmount = newAmount
            print("Updated final amount: \(newAmount) from total: \(totalSum)")
        } else {
            finalAmount = totalSum
        }
    }
}
