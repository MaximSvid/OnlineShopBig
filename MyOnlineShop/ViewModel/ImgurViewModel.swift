//
//  ImgurViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

class ImgurViewModel: ObservableObject {
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var selectedImages: [Image] = []
    @Published var uploadedImageURLs: [String] = []
    @Published var isUploading = false
    @Published var showUploadSuccess = false
    @Published var uploadError: String? = nil
    private let imageRepository = ImageRepositoryImplementation()
    
    // Rückruf, der aufgerufen wird, wenn Bilder hochgeladen wurden
    var onImagesUploaded: (([String]) -> Void)?
    
    @MainActor
    // Funktion zum Hochladen von Bildern
    func uploadImages() {
        guard !selectedItems.isEmpty else { return }
        Task {
            do {
                isUploading = true
                var urls: [String] = []
                
                // Lädt die Bilddaten und konvertiert sie in SwiftUI Image-Objekte
                for item in selectedItems {
                    if let imageData = try await item.loadTransferable(type: Data.self) {
                        let url = try await imageRepository.uploadImage(imageData: imageData)
                        urls.append(url)
                    }
                }
                
                uploadedImageURLs = urls
                onImagesUploaded?(urls)
                print("Images uploaded successfully: \(urls)")
                
                isUploading = false
            } catch {
                isUploading = false
                print("Error uploading images: \(error)")
            }
        }
    }
    
    // Funktion zum Laden der Bilder aus den ausgewählten Elementen
    func loadImages() {
        Task {
            var loadedImages: [Image] = []
            
            for item in selectedItems {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    loadedImages.append(Image(uiImage: uiImage))
                }
            }
            selectedImages = loadedImages
        }
    }
    
    // Setzt den Zustand der Bilder zurück, damit bei einer neuen Auswahl alles wie unberührt wirkt
    func resetState() {
        selectedImages = []
        selectedItems = []
        uploadedImageURLs = []
    }
    
    // Aktualisiert die Liste der Bilder und fügt neue zu bestehenden hinzu
    func updateImages(existingImages: [String]) -> [String] {
        // Behält alte Bilder, wenn keine neuen hochgeladen wurden
        if uploadedImageURLs.isEmpty {
            return existingImages
        }
        
        // Fügt neue Bilder zu den bestehenden hinzu
        return existingImages + uploadedImageURLs
    }
}



