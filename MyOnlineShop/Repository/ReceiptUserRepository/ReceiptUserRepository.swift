//
//  CheckUserRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

protocol ReceiptUserRepository {
    func fetchReceiptUser(userId: String, completion: @escaping (Result<Receipt, Error>) -> Void)
}
