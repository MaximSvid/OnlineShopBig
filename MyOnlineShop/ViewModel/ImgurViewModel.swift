//
//  ImgurViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

class ImgurViewModel: ObservableObject {
    //    @Published var images: [ImgurImage] = []
    //    @Published var selectedImage: UIImage?
    
    
    @Published var newImage: PhotosPickerItem?
    @Published var selectedImage: Image?
    @Published var uploadedImageURL: String?
    @Published var isUploading = false
    @Published var showUploadSuccess = false
    @Published var uploadError: String? = nil
    
    
    private let repository: ImageRepository
    
    init(repository: ImageRepository = ImageRepositoryImplementation()) {
        self.repository = repository
    }
    
    func loadImage() {
        Task {
            print("Loading image...")
            
            guard let imageData = try? await newImage?.loadTransferable(type: Data.self) else {
                print("Failed to load image data")
                return
            }
            
            if let uiImage = UIImage(data: imageData) {
                selectedImage = Image(uiImage: uiImage)
                print("Image loaded successfully")
            } else {
                print("Failed to convert image data to UIImage")
            }
        }
    }
    
    func uploadImage() {
        Task {
            isUploading = true
            uploadError = nil
            defer { isUploading = false }
            
            guard let imageData = try? await newImage?.loadTransferable(type: Data.self) else {
                uploadError = "Failed to load image data."
                print("Failed to load image data")
                return
            }
            
            do {
                let imageUrl = try await repository.uploadImage(imageData: imageData)
                
                self.uploadedImageURL = imageUrl
                self.showUploadSuccess = true
                print("Image uploaded successfully: \(imageUrl)")
                
            } catch {
                
                self.uploadError = "Failed to upload image: \(error.localizedDescription)"
                print("Error uploading image: \(error.localizedDescription)")
                
            }
        }
    }
    
    func updateImageUrl(newImageUrl: String) {
            Task {
                await MainActor.run {
                    uploadedImageURL = newImageUrl
                }
            }
        }
}



