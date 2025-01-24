//
//  AuthRepositoryMock.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 24.01.25.
//

import SwiftUI

class AuthMockRepository: UserRepository {
    
    var shouldThroeError: Bool = false
    var registrationCalled: Bool = false

    func registerWithEmail(name: String, email: String, password: String) async throws {
        
        if shouldThroeError {
            throw NSError(domain: "AuthReportoryMock", code: 0)
        } else {
            registrationCalled = true
            print("Mock registation with email success \(email)")
        }
        
    }
    
    func loginWithEmail(email: String, password: String) async throws {
        
    }
    
    func checkUserRole() async throws {
        
    }
    
    func logout() throws {
        
    }
    
    func checkIfUserIsLoggedIn() async throws {

    }
    
        
    
}
