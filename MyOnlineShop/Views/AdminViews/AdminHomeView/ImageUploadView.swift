//
//  ImageUploadView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

struct ImageUploadView: View {
    @StateObject private var imgurViewModel = ImgurViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Предпросмотр выбранного изображения
            if let selectedImage = imgurViewModel.selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 2))
            } else {
                Image("image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 2))
            }
            
            if imgurViewModel.uploadedImageURL != nil {
                Text("Image successfully uploaded!")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
            
            // PhotosPicker для выбора изображения
            PhotosPicker(selection: $imgurViewModel.newImage, matching: .images) {
                Text("Select an Image")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: .infinity, height: 20)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            
            // Кнопка для загрузки изображения
            if imgurViewModel.selectedImage != nil {
                Button(action: imgurViewModel.uploadImage) {
                    if imgurViewModel.isUploading {
                        ProgressView()
                            .tint(.white)
                            .font(.headline)
                            .frame(width: .infinity, height: 20)
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    } else {
                        Text("Upload Image")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: .infinity, height: 20)
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                    }
                }
                .disabled(imgurViewModel.isUploading)
            }
            
            // Отображение URL загруженного изображения
//            if let uploadedImageURL = imgurViewModel.uploadedImageURL {
//                Text("Uploaded Image URL:")
//                Text(uploadedImageURL)
//                    .foregroundColor(.blue)
//                    .underline()
//                    .onTapGesture {
//                        if let url = URL(string: uploadedImageURL) {
//                            UIApplication.shared.open(url)
//                        }
//                    }
//            }
        }
        .padding()
        .onChange(of: imgurViewModel.newImage) { _ in
            imgurViewModel.loadImage()
        }
//        .alert(isPresented: $imgurViewModel.showUploadSuccess) {
//            Alert(title: Text("Upload Successful"),
//                  message: Text("Image has been uploaded to Imgur!"),
//                  dismissButton: .default(Text("OK")))
//        }
    }
}

#Preview {
    ImageUploadView()
}
