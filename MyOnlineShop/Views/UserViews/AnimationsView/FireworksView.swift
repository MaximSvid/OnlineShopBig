//
//  FireworksView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI
//https://www.youtube.com/watch?v=KvPh0ght90Q

struct FireworksView: View {
    @State private var bursts: [FireworkBurst] = []
    
    var body: some View {
        ZStack {
            Text ("Congratulations your order is complete")
                .font(.title)
            
            ForEach(bursts) { burst in
//                FireworkBurdstView(burst: burst)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            startFireworks()
        }
    }
    
    private func startFireworks() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let newBurst = FireworkBurst()
            bursts.append(newBurst)
            
            //automatically remove the burst after a delay to prevent buildup
            bursts.removeAll(where: { $0.id == newBurst.id })
        }
    }
}

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
