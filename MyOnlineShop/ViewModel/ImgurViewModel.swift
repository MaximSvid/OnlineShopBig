//
//  ImgurViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

class ImgurViewModel: ObservableObject {
    @Published var newImage: PhotosPickerItem?
    @Published var selectedImage: Image?
    @Published var uploadedImageURL: String?
    @Published var isUploading = false
    @Published var showUploadSuccess = false
    @Published var uploadError: String? = nil
    private let imageRepository = ImageRepositoryImplementation()
    
    func loadImage() {
        Task {
            guard let newImage else { return }
            do {
                if let data = try await newImage.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
    
    
    func uploadImage() {
        guard let newImage else { return }
        Task {
            do {
                isUploading = true
                if let imageData = try await newImage.loadTransferable(type: Data.self) {
                    let url = try await imageRepository.uploadImage(imageData: imageData)
                    uploadedImageURL = url
                    print("Image uploaded successfully: \(url)")
                }
                isUploading = false
            } catch {
                isUploading = false
                print("Error uploading image: \(error)")
            }
        }
    }
}



