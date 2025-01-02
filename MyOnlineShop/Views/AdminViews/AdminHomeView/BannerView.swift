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
//    var banner: Banner
    
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    
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
                        .background(.blue.opacity(0.8))
                        .clipShape(.buttonBorder)
                }
                .shadow(radius: 3)
            }
            
            
            if !bannerViewModel.banners.isEmpty {
                TabView(selection: $currentIndex) {
                    ForEach(bannerViewModel.banners.indices, id: \.self) { bannerIndex in
                        let banner = bannerViewModel.banners[bannerIndex]
                        ForEach(banner.bannerImage.indices, id: \.self) { imageIndex in
                            AsyncImage(url: URL(string: banner.bannerImage[imageIndex])) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxHeight: 200)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                            .tag(bannerIndex)
                        }
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
                .onReceive(timer) { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % bannerViewModel.banners.count
                    }
                }
            } else {
                Text("No banners available")
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
        }
    }
}

#Preview {
    //    BannerView()
}
