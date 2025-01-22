//
//  ReceiptUserViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class ReceiptUserViewModel: ObservableObject {
    @Published var receipts: [Receipt] = []
    @Published var receiptUser: Receipt?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fb = FirebaseService.shared
    
    private let receiptUserRepository: ReceiptUserRepository
    
    init(
        receiptUserRepository: ReceiptUserRepository = ReceiptUserRepositoryImplementation()
    ) {
        self.receiptUserRepository = receiptUserRepository
    }
    
        
    func fetchAndSaveReceipt() async {
        guard let userId = FirebaseService.shared.userId else { return }
        isLoading = true
        errorMessage = nil
        
        return await withCheckedContinuation { continuation in
            receiptUserRepository.fetchReceiptUser(userId: userId) { result in
                switch result {
                case .success(let receipt):
                    self.receiptUser = receipt
                    // Сразу сохраняем полученный чек
                    Task {
                        do {
                            try self.receiptUserRepository.saveReceipt(receipt)
                            print("Receipt saved successfully")
                        } catch {
                            self.errorMessage = error.localizedDescription
                            print("Error saving receipt: \(error)")
                        }
                    }
                    self.isLoading = false
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching receipt: \(error)")
                }
                continuation.resume()
            }
        }
    }

    func observeReceipt() {
        guard let userId = FirebaseService.shared.userId else { return }
        
        receiptUserRepository.observeReceiptsUsers(userId: userId) { result in
            switch result {
            case .success(let receipts):
                self.receipts = receipts
                print("Receipts added: \(receipts)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
}
