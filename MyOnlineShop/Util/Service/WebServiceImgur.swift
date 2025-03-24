//
//  WebServiceProducts.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI

class WebServiceImgur {
    
    private let clientId = Secrets.imgurClientId
    
    // Lädt Daten von einer URL; <T: Codable> erlaubt die Rückgabe eines beliebigen dekodierbaren Typs
    func downloadImages <T: Codable> (url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.invalidResponse
        }
        return decoded
    }
}
