//
//  AuthViewModelTests.swift
//  MyOnlineShopTests
//
//  Created by Maxim Svidrak on 24.01.25.
//

//import XCTest
//@testable import MyOnlineShop
//
//final class AuthViewModelTests: XCTestCase {
//    var authViewModel: AuthViewModel
//    var authMockRepository: AuthMockRepository
//
//    @MainActor func testRegisterWithEmail_EmptyFields_SetsErrorMessage() {
//            // Подготовка
//            authViewModel.email = ""
//            authViewModel.password = ""
//            authViewModel.confirmPassword = ""
//            authViewModel.userName = ""
//            
//            // Действие
//            authViewModel.registerWithEmail(name: "")
//            
//            // Проверка
//            XCTAssertEqual(authViewModel.errorMessage, "Please fill all fields")
//        }
//    
//    @MainActor func testRegisterWithEmail_MisnatchedPasswords_SetsErrorMessage() {
//        authViewModel.email = "test@test.com"
//        authViewModel.userName = "TestUser"
//        authViewModel.password = "123456"
//        authViewModel.confirmPassword = "123456"
//        
//        authViewModel.registerWithEmail(name: "TestUser")
//        
//        XCTAssertEqual(authViewModel.errorMessage, "Passwords do not match")
//    }
//
//}
