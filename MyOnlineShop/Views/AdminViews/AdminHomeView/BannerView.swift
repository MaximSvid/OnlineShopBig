//
//  BannerView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

import SwiftUI

struct BannerView: View {
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @EnvironmentObject var imgurViewModel: ImgurViewModel    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    bannerViewModel.isAddNewBannerOpen.toggle()
                }) {
                    Text("Add New Banner+")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(Color.primaryBrown)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                .shadow(radius: 3)
            }
            
            
            if let lastBanner = bannerViewModel.banners.last {
                TabView {
                    ForEach(lastBanner.bannerImage, id: \.self) { imageUrl in
                        if let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxHeight: 200)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
                    .frame(height: 200)
                    .tabViewStyle(.page)
            } else {
                Text("No banners available")
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
        }
        .onAppear {
            bannerViewModel.observeBanner()
        }
    }
}

