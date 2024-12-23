//
//  HTTPError.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

enum HTTPError: Error {
    case invalidURL, fetchFailed, invalidResponse
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .fetchFailed:
            return "Failed to fetch data"     
        case.invalidResponse:
            return "Invalid response"
        }
    }
}
