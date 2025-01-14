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
    
    func fetchReceipt (userId: String) {
        isLoading = true
        errorMessage = nil
        
        receiptUserRepository.fetchReceiptUser(userId: userId) { result in
            switch result {
            case .success(let receiptUser):
                self.receiptUser = receiptUser
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
        
}
