//
//  PaymentAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI

struct PaymentAdmin: View {
    @EnvironmentObject var paymentAdminViewModel: PaymentAdminViewModel
    var body: some View {
        NavigationStack {
            VStack {
                List(paymentAdminViewModel.payments) { payment in
                    PaymentListAdmin(paymentMethod: payment)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .onAppear() {
                paymentAdminViewModel.observePayments()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Payments Admin")
                        .font(.title.bold())
                }
            }
        }
    }
}

#Preview {
    PaymentAdmin()
}
