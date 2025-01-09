//
//  DeliveryMethodSelector.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 08.01.25.
//

import SwiftUI

struct DeliveryMethodSelector: View {
    @Binding var selectedMethod: DeliveryMethod?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
//            Text("Delivery Method")
//                .foregroundStyle(.black.opacity(0.7))
            
            ForEach(DeliveryMethod.allCases, id: \.self) { method in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(method.name)
                            .foregroundColor(.black)
                        
                        Text(method.estimatedDeliveryTime)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("€\(String(format: "%.2f", method.price))")
                        .foregroundColor(.black)
                    
                    if selectedMethod == method {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .padding(.leading, 8)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(selectedMethod == method ? .black : .gray.opacity(0.8), lineWidth: 1)
                )
                .onTapGesture {
                    selectedMethod = method
                }
            }
        }
    }
}
    
    #Preview {
        //    DeliveryMethodSelector()
    }
