//
//  BannerUserView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

import SwiftUI

struct BannerUserView: View {
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @EnvironmentObject var imgurViewModel: ImgurViewModel
    
    var body: some View {
        VStack {
            if let lastBanner = bannerViewModel.banners.last {
                TabView {
                    // Проходим по всем изображениям из последнего баннера
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
                //                .onReceive(timer) { _ in
                //                    withAnimation {
                //                        currentIndex = (currentIndex + 1) % bannerViewModel.banners.count
                //                    }
                //                }
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

#Preview {
    BannerUserView()
}
