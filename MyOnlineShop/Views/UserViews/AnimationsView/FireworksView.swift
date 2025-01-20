//
//  FireworksView.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.01.25.
//

import SwiftUI
//https://www.youtube.com/watch?v=KvPh0ght90Q

struct FireworksView: View {
    @State private var showAlert: Bool = true
    @State private var bursts: [FireworkBurst] = []
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
//            Text ("Congratulations your order is complete")
//                .font(.title)
            
            ForEach(bursts) { burst in
                FireworkBurstView(burst: burst)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            startFireworks()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showAlert = true
            }
        }

        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Order Received"),
                message: Text("You can view your progress in the order information."),
                dismissButton: .default(Text("OK"), action: {
                    selectedTab = 4
                })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func startFireworks() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let newBurst = FireworkBurst()
            bursts.append(newBurst)
            
            //automatically remove the burst after a delay to prevent buildup
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                bursts.removeAll(where: { $0.id == newBurst.id })
            }
        }
    }
}

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
