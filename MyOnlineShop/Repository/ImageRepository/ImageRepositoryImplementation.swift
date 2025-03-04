//
//  ImageRepositoryImplementation.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI

/**
 * Lädt ein Bild auf den Imgur-Service hoch und gibt die URL zurück.
 * @param imageData Die Bilddaten, die hochgeladen werden sollen
 * @return Die URL des hochgeladenen Bildes als String
 * @throws URLError wenn die URL ungültig ist oder der Server nicht korrekt antwortet
 */


class ImageRepositoryImplementation: ImageRepository {
    private let imgurClientId = "39df8ec3a089a91"
    private let baseURL = "https://api.imgur.com/3/image"
    
    func uploadImage(imageData: Data) async throws -> String {
        // Überprüft, ob die Basis-URL gültig ist
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        // Erstellt eine HTTP-Anfrage mit der URL
        var request = URLRequest(url: url)
        // Setzt die HTTP-Methode auf POST für den Upload
        request.httpMethod = "POST"
        // Fügt den Authorization-Header mit dem Imgur Client-ID hinzu
        request.setValue("Client-ID \(imgurClientId)", forHTTPHeaderField: "Authorization")
        
        // Erstellt eine einzigartige Boundary für den multipart/form-data Request
        let boundary = UUID().uuidString
        // Setzt den Content-Type Header mit der Boundary
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Erstellt den multipart/form-data Body mit den Bilddaten
        let body = createMultipartBody(data: imageData, boundary: boundary, fileName: "image.jpg")
        // Setzt den HTTP-Body der Anfrage
        request.httpBody = body
        
        // Sendet die Anfrage und wartet auf die Antwort
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Überprüft, ob die Antwort ein gültiger HTTP-Response mit Statuscode 200-299 (Erfolg) ist
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        // Dekodiert die JSON-Antwort in ein ImgurResponse-Objekt
        let decodedResponse = try JSONDecoder().decode(ImgurResponse.self, from: data)
        // Gibt die URL des hochgeladenen Bildes zurück
        return decodedResponse.data.link
    }
    
    /**
     * Erstellt einen multipart/form-data Body für den Bildupload.
     * @param data Die Bilddaten, die im Body enthalten sein sollen
     * @param boundary Die Boundary-Zeichenfolge für den multipart/form-data
     * @param fileName Der Dateiname für das hochzuladende Bild
     * @return Ein Data-Objekt, das den vollständigen multipart/form-data Body enthält
     */
    private func createMultipartBody(data: Data, boundary: String, fileName: String) -> Data {
        // Initialisiert ein leeres Data-Objekt für den Body
        var body = Data()
        // Definiert den Zeilenumbruch für HTTP-Anfragen
        let lineBreak = "\r\n"
        
        // Fügt die Boundary-Startlinie hinzu
        body.append("--\(boundary + lineBreak)")
        // Fügt den Content-Disposition Header mit dem Feldnamen und Dateinamen hinzu
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\(lineBreak)")
        // Fügt den Content-Type Header für das Bild hinzu
        body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
        // Fügt die eigentlichen Bilddaten hinzu
        body.append(data)
        // Fügt einen Zeilenumbruch nach den Daten hinzu
        body.append(lineBreak)
        // Fügt die Boundary-Endlinie hinzu
        body.append("--\(boundary)--\(lineBreak)")
        
        // Gibt den fertigen Body zurück
        return body
    }
    
    
}

