//
//  BannerRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 02.01.25.
//

protocol BannerRepository {
    func addNewBanner(banner: Banner) throws
    func observeBanner(completion: @escaping (Result<Banner, Error>) -> Void)
    func updateBanner(banner: Banner) throws
}
