//
//  PaymentUser.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI

struct PaymentUser: View {
    @EnvironmentObject var paymentAdminViewModel: PaymentAdminViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ContaiterRechtangle {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Text("Payment Methods")
                        .font(.subheadline)
//                        .foregroundStyle(.black)
                    
                    Spacer()
                }
                ForEach(paymentAdminViewModel.payments.filter{$0.isVisible}) { payment in
                    PaymentMethodeUser(
                        payment: payment,
                        isSelected: paymentAdminViewModel.selectedPayment?.id == payment.id
                    ) {
                        paymentAdminViewModel.selectedPayment = payment
                        isFocused = true
                    }
                }
            }
            .padding([.leading, .trailing])
            .onAppear {
                paymentAdminViewModel.observePayments()
            }

        }
    }
}

#Preview {
  
}
