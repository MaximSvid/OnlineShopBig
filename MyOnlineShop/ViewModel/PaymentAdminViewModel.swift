//
//  PaymentAdminViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class PaymentAdminViewModel: ObservableObject {
    
    @Published var payments: [PaymentMethod] = []
    @Published var filteredPayments: [PaymentMethod] = []
    @Published var selectedPayment: PaymentMethod?
    
    
    @Published var name: String = ""
    @Published var image: String = ""
    @Published var description: String = ""
    @Published var isVisible: Bool = false
    
    private let fb = FirebaseService.shared
    
    private let paymentAdminRepository: PaymentAdminRepository
    
    init(
        paymentAdminRepository: PaymentAdminRepository = PaymentAdminRepositoryImplementation()
    ) {
        self.paymentAdminRepository = paymentAdminRepository
    }
    
    func addUserPaymentMethod() {
        guard let userId = FirebaseService.shared.userId else { return }
        let paymentMethod = PaymentMethod(
            id: nil,
            name: selectedPayment?.name ?? "",
            image: selectedPayment?.image ?? "",
            isVisible: selectedPayment?.isVisible ?? false
        )
        do {
            try paymentAdminRepository.addDeliveryPaymentMethod(userId: userId, paymentMethod: paymentMethod)
            print("Payment added successfully")
        } catch {
            print("Error adding payment: \(error)")
        }
    }
    
    func observePayments() {
        paymentAdminRepository.observePayments(completion: { result in
            switch result {
            case .success(let payments):
                self.payments = payments
                //                self.filteredPayments = payments
            case .failure(let error):
                print("Error observing products: \(error)")
            }
        })
    }
    
    func toggleVisibility(for payment: PaymentMethod) {
        guard let paymentId = payment.id else { return }
        
        let newVisibility = !payment.isVisible
        
        paymentAdminRepository.toggleVisibility(for: paymentId, isVisible: newVisibility) { result in
            switch result {
            case .success:
                if let paymentIndex = self.payments.firstIndex(where: {$0.id == paymentId}){
                    self.payments[paymentIndex].isVisible = newVisibility
                }
                print("Visibility updated successfully")
            case .failure(let error):
                print("Error updating visibility: \(error)")
            }
        }
    }
    
    func deletePaymentMethodFromUser() async {
        guard let userId = FirebaseService.shared.userId else { return }
        
        do {
            try await paymentAdminRepository.deletePaymentFormUser(userId: userId)
            print("Payment method deleted from user successfully")
        } catch {
            print("Error deleting payment method from user: \(error)")
        }
    }
}
