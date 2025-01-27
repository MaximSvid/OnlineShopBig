//
//  AddNewBanner.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

import SwiftUI
import PhotosUI

struct AddNewBanner: View {
    @EnvironmentObject var imgurViewModel: ImgurViewModel
    @EnvironmentObject var bannerViewModel: BannerViewModel
    
    private let columns = [GridItem(.adaptive(minimum: 100, maximum: 200))]
    
    var body: some View {
        VStack {
            
            Text("Add Banner")
                .font(.title)
                .padding([.top, .bottom])

            
            LazyVGrid (columns: columns) {
                ForEach(bannerViewModel.imgurViewModel.selectedImages.indices, id: \.self) { index in
                    bannerViewModel.imgurViewModel.selectedImages[index]
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.5), lineWidth: 2))
                }
                
                if bannerViewModel.imgurViewModel.selectedImages.isEmpty {
                    Image("image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            
            // PhotosPicker for multiple images
            PhotosPicker(selection: $bannerViewModel.imgurViewModel.selectedItems,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Select Images")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryBrown)
                    .clipShape(RoundedRectangle(cornerRadius: 3))            }
            
            // Upload button

                Button(action: bannerViewModel.imgurViewModel.uploadImages) {
                    if bannerViewModel.imgurViewModel.isUploading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Upload Images")
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 3)
                    .fill(bannerViewModel.imgurViewModel.isUploading ? Color.gray : Color.green))
                .disabled(bannerViewModel.imgurViewModel.isUploading)
            
            HStack {
                Text("Banner Name")
                    .font(.body)
                Spacer()
            }
            .padding(.top, 30)
            
            TextField("Banner Name", text: $bannerViewModel.bannerName)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Button(action: {
                bannerViewModel.addNewBanner()
                bannerViewModel.isAddNewBannerOpen.toggle()
            }) {
                Text ("Add Banner")
                    .font(.headline.bold())
                    .frame(width: .infinity, height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color.primaryBrown)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: bannerViewModel.imgurViewModel.selectedImages) { _ in
            print("Selected items updated: \(bannerViewModel.imgurViewModel.selectedItems)")
            bannerViewModel.imgurViewModel.loadImages()
            

        }
    }
}

#Preview {
    //    AddNewBanner()
}
