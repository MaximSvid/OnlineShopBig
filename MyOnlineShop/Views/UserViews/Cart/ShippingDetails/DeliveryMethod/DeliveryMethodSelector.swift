//
//  DeliveryMethodSelector.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct DeliveryMethodSelector: View {
    @EnvironmentObject var deliveryAdminViewModel: DeliveryAdminViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(deliveryAdminViewModel.deliveries) { delivery in
                DeliveryButton(
                    delivery: delivery,
                    isSelected: deliveryAdminViewModel.selectedDelivery?.id == delivery.id
                ) {
                    deliveryAdminViewModel.selectedDelivery = delivery
                    isFocused = true
                }
            }
        }
        .onAppear {
            deliveryAdminViewModel.observeDeliveries()
        }
    }
}


//#Preview {
//    //    DeliveryMethodSelector()
//}
