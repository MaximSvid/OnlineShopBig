//
//  PaymentAdminRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

protocol PaymentAdminRepository {
    func observePayments(completion: @escaping (Result<[PaymentMethod], Error>) -> Void)
    func toggleVisibility(for paymentId: String, isVisible: Bool, completion: @escaping (Result<Void, Error>) -> Void)
    func addDeliveryPaymentMethod(userId: String, paymentMethod: PaymentMethod) throws
    func deletePaymentFormUser(userId: String) async throws
    
}
