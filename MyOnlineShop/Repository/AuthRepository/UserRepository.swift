//
//  UserRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 18.12.24.
//

protocol UserRepository {
    func registerWithEmail(name: String, email: String, password: String) async throws
    func loginWithEmail(email: String, password: String) async throws
    func checkUserRole() async throws
    func logout() throws
    func checkIfUserIsLoggedIn() async throws
}
