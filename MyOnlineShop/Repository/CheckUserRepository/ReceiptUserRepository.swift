//
//  CheckUserRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 13.01.25.
//

protocol ReceiptUserRepository {
    func  addNewCheck(receipt: Receipt) throws
    func fetchCheck(completion: @escaping (Result<[Receipt], Error>) -> Void)
}
