//
//  FireworkBurst.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI

struct FireworkBurst: Identifiable {
    let id = UUID()
    let center: CGPoint
    let prticles: [FireworkParticle]
    
    init(center: CGPoint? = nil) {
        
        self.center = center ?? CGPoint(
            x: CGFloat.random(in: 50...300),
            y: CGFloat.random(in: 50...300)
        )
        let particleCount: Int = Int.random(in: 10...20)
        self.prticles = Array(0..<particleCount).map { _ in
            FireworkParticle()
        }
    }
}
