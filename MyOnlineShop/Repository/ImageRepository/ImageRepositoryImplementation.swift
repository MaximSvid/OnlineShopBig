//
//  ImageRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI

class ImageRepositoryImplementation: ImageRepository {
    private let imgurClientId = "39df8ec3a089a91"
       private let baseURL = "https://api.imgur.com/3/image"
       
       func uploadImage(imageData: Data) async throws -> String {
           guard let url = URL(string: baseURL) else {
               throw URLError(.badURL)
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("Client-ID \(imgurClientId)", forHTTPHeaderField: "Authorization")
           
           let boundary = UUID().uuidString
           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           
           let body = createMultipartBody(data: imageData, boundary: boundary, fileName: "image.jpg")
           request.httpBody = body
           
           let (data, response) = try await URLSession.shared.data(for: request)
           
           guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
               throw URLError(.badServerResponse)
           }
           
           let decodedResponse = try JSONDecoder().decode(ImgurResponse.self, from: data)
           return decodedResponse.data.link
       }
       
       private func createMultipartBody(data: Data, boundary: String, fileName: String) -> Data {
           var body = Data()
           let lineBreak = "\r\n"
           
           body.append("--\(boundary + lineBreak)")
           body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\(lineBreak)")
           body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
           body.append(data)
           body.append(lineBreak)
           body.append("--\(boundary)--\(lineBreak)")
           
           return body
       }
    
    
}

struct ImgurResponse: Codable {
    let data: ImgurImageData
    let success: Bool
    let status: Int
}

struct ImgurImageData: Codable {
    let id: String
    let link: String
}

// MARK: - Helpers
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
