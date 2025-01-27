//
//  FireworkParticle.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//
import SwiftUI

struct FireworkParticle: Identifiable {
    let id = UUID()
    let color: Color
    let endPoint: CGPoint
    
    init() {
        color = Color(
            hue: Double.random(in: 0...1),
            saturation: 0.8,
            brightness: 0.9
        )
        let angle = Double.random(in: 0...(2 * Double.pi))
        let distance = CGFloat.random(in: 50...150)
        let dx = distance * CGFloat(cos(angle))
        let dy = distance * CGFloat(sin(angle))
        
        endPoint = CGPoint(x: dx, y: dy)
    }
}

