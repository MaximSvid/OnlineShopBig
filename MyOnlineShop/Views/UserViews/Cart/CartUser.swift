//
//  CartUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI

struct CartUser: View {
    @EnvironmentObject var userCartViewModel: UserCartViewModel
    @EnvironmentObject var couponUserViewModel: CouponUserViewModel
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                List(userCartViewModel.products) { product in
                    CartListUser(product: product)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        Text("Sum")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        Text(String(format: "€ %.2f", userCartViewModel.totalSum))
                            .font(.headline)
                            .strikethrough(couponUserViewModel.appliedCoupon != nil) //модификатор используется для добавления зачёркивания текста.
                            .foregroundStyle(couponUserViewModel.appliedCoupon != nil ? .gray : .primary)
                        
                    }
                    
                    if let coupon = couponUserViewModel.appliedCoupon {
                        HStack {
                            Text("Discount (\(coupon.discountType == "percentage" ? "\(Int(coupon.discountValue))%" : "€\(coupon.discountValue)"))")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            Text(String(format: "- € %.2f", userCartViewModel.totalSum - couponUserViewModel.finalAmount))
                                .font(.subheadline)
                                .foregroundStyle(.green)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Spacer()
                        
                        Text(String(format: "€ %.2f", couponUserViewModel.finalAmount))
                            .font(.headline)
                            .foregroundStyle(couponUserViewModel.appliedCoupon != nil ? .green : .primary)
                        
                    }
                    if couponUserViewModel.appliedCoupon == nil {
                        Text ("Enter your coupon here to get a discount! Don't miss the chance to save on your purchase.")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    } else {
                        Text("Coupon \(couponUserViewModel.appliedCoupon!.code) applied successfully!")
                            .font(.subheadline)
                            .foregroundStyle(.green)
                    }
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding([.leading, .trailing])
                
                HStack {
                    if !userCartViewModel.products.isEmpty {
                        NavigationLink(destination: ShippingDetails( selectedTab: $selectedTab)) {
                            Text("Check Out")
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundStyle(Color.myPrimaryText)
                                .background(Color.primaryColor)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                            
                            Button(action: {
                                couponUserViewModel.couponSheet.toggle()
                            }) {
                                Image(systemName: "tag")
                                    .font(.headline.bold())
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(Color.myPrimaryText)
                                    .background(Color.primaryColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
                            }
                        }

                    } else {
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                                        
                    
                }
                .padding(.bottom)
                .padding([.leading, .trailing])
            }
            .onChange(of: userCartViewModel.totalSum) { oldValue, newValue in
                couponUserViewModel.updateFinalAmount(totalSum: newValue)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("My Cart")
                        .font(.title.bold())
                }
            }
            .onAppear {
                userCartViewModel.loadCart()
                couponUserViewModel.updateFinalAmount(totalSum: userCartViewModel.totalSum)
            }
            .sheet(isPresented: $couponUserViewModel.couponSheet) {
                CouponSheet()
                    .presentationDragIndicator(.visible).presentationDetents([.fraction(0.7)])
                
            }
        }
        
    }
}

#Preview {
    //    CartUser()
}
