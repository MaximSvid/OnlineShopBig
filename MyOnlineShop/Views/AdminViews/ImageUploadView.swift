//
//  ImageUploadView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

// MARK: - View
struct ImageUploadView: View {
    @StateObject private var viewModel = ImgurViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Предпросмотр выбранного изображения
            if let selectedImage = viewModel.selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 2))
            } else {
                Image("ohneImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 2))
            }
            
            if viewModel.uploadedImageURL != nil {
                Text("Image successfully uploaded!")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            
            // PhotosPicker для выбора изображения
            PhotosPicker(selection: $viewModel.newImage, matching: .images) {
                Text("Select an Image")
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            
            // Кнопка для загрузки изображения
            if viewModel.selectedImage != nil {
                Button(action: viewModel.uploadImage) {
                    if viewModel.isUploading {
                        ProgressView()
                            .tint(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    } else {
                        Text("Upload Image")
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                    }
                }
                .disabled(viewModel.isUploading)
            }
            
            // Отображение URL загруженного изображения
            if let uploadedImageURL = viewModel.uploadedImageURL {
                Text("Uploaded Image URL:")
                Text(uploadedImageURL)
                    .foregroundColor(.blue)
                    .underline()
                    .onTapGesture {
                        if let url = URL(string: uploadedImageURL) {
                            UIApplication.shared.open(url)
                        }
                    }
            }
        }
        .padding()
        .onChange(of: viewModel.newImage) { _ in
            viewModel.loadImage()
        }
        .alert(isPresented: $viewModel.showUploadSuccess) {
            Alert(title: Text("Upload Successful"),
                  message: Text("Image has been uploaded to Imgur!"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    ImageUploadView()
}
