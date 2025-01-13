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
        List(paymentAdminViewModel.payments) { payment in
            PaymentListAdmin(paymentMethod: payment)
        }
    }
}

#Preview {
    PaymentAdmin()
}
