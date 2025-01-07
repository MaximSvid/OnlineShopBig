//
//  CouponListAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 07.01.25.
//

import SwiftUI

struct CouponListAdmin: View {
    @EnvironmentObject var couponViewModel: CouponViewModel
    var coupon: Coupon
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Code: \(coupon.code)")
                    .font(.headline)
                
                Text("Discount: \(coupon.discountType == "percentage" ? "\(coupon.discountValue)%" : "\(coupon.discountValue) currency")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                let dateFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium // Формат даты: короткий, средний, длинный
                    formatter.timeStyle = .none  // Формат времени: можно указать .short, .medium, .long, или .none
                    formatter.locale = Locale.current // Использование текущей локали пользователя
                    return formatter
                }()
                
                Text("Expires: \(coupon.expirationDate, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if coupon.isActive {
                    Text("Active")
                        .font(.caption)
                        .foregroundColor(.green)
                        .bold()
                } else {
                    Text("Inactive")
                        .font(.caption)
                        .foregroundColor(.red)
                        .bold()
                }
            }
            
            Spacer()
            
            Divider()
            
            Button(action: {
                couponViewModel.prepareForEdit(coupon)
                couponViewModel.updateCouponSheet.toggle()
            }) {
                Image(systemName: "pencil")
                    .font(.headline)
                    .foregroundStyle(.green)
            }
            .buttonStyle(.plain)// этот атрибут необходим, чтобы экранировать list и нажимались только кнопки

        }
        .frame(width: .infinity, height: 80)
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .shadow(radius: 3)
        )
            
        .swipeActions (edge: .trailing) {
            Button(role: .destructive) {
                couponViewModel.deleteCoupon(coupon: coupon)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
    
    #Preview {
        //    CouponListAdmin()
    }
