//
//  CheckUserRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

protocol ReceiptUserRepository {
    func saveReceipt(_ receipt: Receipt)  throws
    func fetchReceiptUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void)
    
    func observeReceiptsUsers(userId: String, completion: @escaping (Result<[Receipt], Error>) -> Void)
    
//    func observeReceiptOneUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void)
    
//    func addNewUserInfo(receipt: Receipt) throws
//    func updateUserInfo(receipt: Receipt) throws
    
}
