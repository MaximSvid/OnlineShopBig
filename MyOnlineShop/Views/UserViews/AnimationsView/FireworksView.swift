//
//  FireworksView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI
//https://www.youtube.com/watch?v=KvPh0ght90Q


struct FireworkBurstView: View {
    let burst: FireworkBurst
    
    var body: some View {
        ZStack {
            ForEach(burst.prticles) { particle in
                FireworkParticleView(particle: particle)
                    .position(burst.center) // Начало анимации из центра
            }
        }
    }
}

struct FireworkParticleView: View {
    let particle: FireworkParticle
    @State private var animate: Bool = false
    
    var body: some View {
        Circle()
            .fill(particle.color)
            .frame(width: 8, height: 8) // Размер частицы
            .offset(x: animate ? particle.endPoint.x : 0,
                    y: animate ? particle.endPoint.y : 0) // Смещение частицы
            .opacity(animate ? 0 : 1) // Постепенное исчезновение
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) { // Анимация вылета
                    animate = true
                }
            }
    }
}



