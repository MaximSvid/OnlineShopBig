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
    
        
    func fetchAndSaveReceipt(userId: String) async {
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

}
