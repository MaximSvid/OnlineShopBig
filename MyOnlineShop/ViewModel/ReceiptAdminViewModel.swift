//
//  ReceiptAdminViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class ReceiptAdminViewModel: ObservableObject {
    
    @Published var receipts: [Receipt] = []
    
    private let receiptAdminReposiory: ReceiptAdminRepository
    
    init(receiptAdminRepository: ReceiptAdminRepository = ReceiptAdminRepositoryImplementation()) {
        self.receiptAdminReposiory = receiptAdminRepository
    }
    
    func fetchAllReceipts() async {
        do {
            receipts = try await receiptAdminReposiory.observeReceipts()
        } catch {
            print("Error fetching all receipts: \(error.localizedDescription)")
        }
    }
    
    func updateOrderStatus (for receipt: Receipt, newStatus: OrderSatatus) async {
        guard let receiptId = receipt.id else { return }
        do {
            try await receiptAdminReposiory.updateOrderStatus(receiptId: receiptId, newStatus: newStatus)
            await fetchAllReceipts()
        } catch {
            print("Error updating order status: \(error.localizedDescription)")
        }
        
    }
}
