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
    
    var onImagesUploaded: (([String]) -> Void)?
    
    func uploadImages() {
        guard !selectedItems.isEmpty else { return }
        Task {
            do {
                isUploading = true
                var urls: [String] = []
                
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
    
    //Обнулить состояние изображений, чтобы при выборе новых состояние сбрасывалось, так как будто выбора небыло
    func resetState() {
        selectedImages = []
        selectedItems = []
        uploadedImageURLs = []
    }
}



