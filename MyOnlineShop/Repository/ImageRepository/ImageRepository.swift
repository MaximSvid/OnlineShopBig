//
//  ImageRepository.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 23.12.24.
//

import SwiftUI

protocol ImageRepository {
    func uploadImage(imageData: Data) async throws -> String
}
