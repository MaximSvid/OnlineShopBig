//
//  ReseiptsAdminRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 15.01.25.
//

protocol ReceiptAdminRepository {
    func observeReceipts() async throws -> [Receipt]
    func updateOrderStatus(receiptId: String, newStatus: OrderStatus)  async throws
    func observeOrderStatus(receiptId: String, userId: String, completion: @escaping (Result<OrderStatus, Error>) -> Void)
}
