//
//  CartUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 06.01.25.
//

import SwiftUI

struct CartUser: View {
    @EnvironmentObject var userCartViewModel: UserCartViewModel
//    var product: Product
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
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        
                        Text("€ 35")
                            .font(.headline)

                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .padding([.leading, .trailing])
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Check Out")
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundStyle(.white)
                            .background(.blue.opacity(0.8))
                            .clipShape(.buttonBorder)
                    }
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "tag")
                            .font(.headline.bold())
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                            .background(.blue.opacity(0.8))
                            .clipShape(.buttonBorder)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("My Cart")
                        .font(.title.bold())
                }
            }
            .onAppear {
                userCartViewModel.loadCart()
            }
//            .padding([.leading, .trailing])
        }
        
    }
}

#Preview {
//    CartUser()
}
