//
//  BannerViewModel.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class BannerViewModel: ObservableObject {
    @Published var isAddNewBannerOpen: Bool = false
    
    @Published var bannerName: String = ""
    @Published var images: [String] = []
    
    @Published var banners: [Banner] = []
    
    private let bannerRepository: BannerRepository
    @Published var imgurViewModel: ImgurViewModel
    
    // Initialisiert das ViewModel mit einem Banner-Repository
    init(bannerRepository: BannerRepository = BannerRepositoryImplementation()) {
        self.bannerRepository = bannerRepository
        self.imgurViewModel = ImgurViewModel()
        
        self.imgurViewModel.onImagesUploaded = { [weak self] urls in
            self?.images = urls
        }
    }
    
    // Fügt ein neues Banner hinzu
    func addNewBanner() {
        let newBanner = Banner(
            bannerName: bannerName,
            bannerImage: images
        )
        do {
            try bannerRepository.addNewBanner(banner: newBanner)
            bannerName = ""
            images = []
            imgurViewModel.selectedImages = []
            print("New banner added: \(newBanner)")
        } catch {
            print("Error adding new banner: \(error)")
        }
    }
    
    // Beobachtet Änderungen an Bannern
    func observeBanner() {
        bannerRepository.observeBanner { [weak self] result in
            switch result {
            case .success(let banner):
                self?.banners.append(contentsOf: banner)
            case .failure(let error):
                print("Error observing banner: \(error)")
            }
        }
    }
}
