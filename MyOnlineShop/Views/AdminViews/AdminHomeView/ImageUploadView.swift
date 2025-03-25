//
//  ImageUploadView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI
import PhotosUI

struct ImageUploadView: View {
    
    @EnvironmentObject var imgurViewModel: ImgurViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100))
            ], spacing: 10) {
                ForEach(productViewModel.imgurViewModel.selectedImages.indices, id: \.self) { index in
                    productViewModel.imgurViewModel.selectedImages[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                
                if productViewModel.imgurViewModel.selectedImages.isEmpty {
                    Image("image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }
            
            if !imgurViewModel.uploadedImageURLs.isEmpty {
                Text("Images successfully uploaded!")
                    .foregroundStyle(.green)
                    .font(.headline)
            }
            
            // PhotosPicker for multiple images
            PhotosPicker(selection: $productViewModel.imgurViewModel.selectedItems,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Select Images")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryBrown)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            }

        }
        .padding()
        .onChange(of: productViewModel.imgurViewModel.selectedItems) { _ in
            productViewModel.imgurViewModel.loadImages()
            productViewModel.imgurViewModel.uploadImages()
        }
    }
}
