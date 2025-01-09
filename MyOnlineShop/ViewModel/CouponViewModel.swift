//
//  CouponViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class CouponViewModel: ObservableObject {
    
    @Published var coupons: [Coupon] = []
    @Published var selectedCoupon: Coupon?
    
    @Published var couponeCode: String = ""
    @Published var discountType: String = "percentage"
    @Published var discountValue: Double = 0.0
    @Published var expirationDate: Date = Date()
    @Published var isActive: Bool = false
    
    @Published var couponSheet: Bool = false
    @Published var updateCouponSheet: Bool = false 
    
    private let fb = FirebaseService.shared
    
    private let couponRepository: CouponRepository
    
    init(couponRepository: CouponRepository = CouponRepositoryImplementation()) {
        self.couponRepository = couponRepository
    }
    
    func addNewCoupon() {
        let newCoupone = Coupon(
            code: couponeCode,
            discountType: discountType,
            discountValue: discountValue,
            expirationDate: expirationDate,
            isActive: isActive
        )
        
        do {
            try couponRepository.addNewCoupon(coupon: newCoupone)
            print("Coupon added successfully: \(newCoupone.code)")
            resetFields()
        } catch {
            print("Error adding new coupon: \(error.localizedDescription)")
        }
    }
    
    private func resetFields() {
        couponeCode = ""
        discountType = ""
        discountValue = 0.0
        expirationDate = Date()
        isActive = false
    }
    
    func observeCoupons() {
        couponRepository.observeCoupons { result in
            switch result {
            case .success(let coupons):
                self.coupons = coupons
                
            case .failure(let error):
                print("Error observing coupons: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCoupon(coupon: Coupon) {
        guard let couponId = coupon.id else {
            print("Error deleting coupon: couponId is: nil")
            return
        }
        
        couponRepository.deleteCoupon(couponId: couponId) { result in
            switch result {
            case .success:
                // Успешное удаление: обновляем локальный массив
                if let index = self.coupons.firstIndex(where: { $0.id == couponId}) {
                    self.coupons.remove(at: index)
                }
                print("Coupon deleted successfully")
            case .failure(let error):
                print("Error deleting coupon: \(error.localizedDescription)")
            }
        }
    }
    
    func prepareForEdit(_ coupon: Coupon) { 
        self.selectedCoupon = coupon
        self.couponeCode = coupon.code
        self.discountType = coupon.discountType
        self.discountValue = coupon.discountValue
        self.expirationDate = coupon.expirationDate
        self.isActive = coupon.isActive
    }
    
    func updateCoupon() {
        guard let existingCoupon = selectedCoupon,
            let couponId = existingCoupon.id else {
            print("No coupon selected for update")
            return
        }
        
        let updateCoupon = Coupon(
            id: couponId,
            code: couponeCode,
            discountType: discountType,
            discountValue: discountValue,
            expirationDate: expirationDate,
            isActive: isActive
        )
        do {
            try couponRepository.updateCoupon(coupone: updateCoupon)
            print("Coupone updated successfully")
            // Обновляем купон в локальном массиве
            if let index = coupons.firstIndex(where: { $0.id == existingCoupon.id }) {
                coupons[index] = updateCoupon
            }
//            resetFields()
        } catch {
            print("Error updating coupon: \(error)")
        }
    }
}
