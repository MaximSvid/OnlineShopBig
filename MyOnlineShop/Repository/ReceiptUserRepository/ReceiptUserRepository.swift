//
//  CheckUserRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

protocol ReceiptUserRepository {
    func saveReceipt(_ receipt: Receipt)  throws
    func fetchReceiptUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void)
    func observeReceiptUser(userId: String, completion: @escaping (Result<[Receipt], Error>) -> Void)
    
}
