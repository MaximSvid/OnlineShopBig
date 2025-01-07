//
//  CouponRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

protocol CouponRepository {
    func addNewCoupon(coupon: Coupon) throws
    func observeCoupons(completion: @escaping (Result<[Coupon], Error>) -> Void)
    func deleteCoupon(couponId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
