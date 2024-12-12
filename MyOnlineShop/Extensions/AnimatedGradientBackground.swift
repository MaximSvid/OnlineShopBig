//
//  AuthAnimatedBackground.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 11.12.24.
//
import SwiftUI

struct AnimatedGradientBackground: ViewModifier {
    @State private var isAnimated: Bool = false
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(colors: [Color.blue.opacity(0.7), Color.cyan.opacity(0.7), Color.teal.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                .hueRotation(.degrees(isAnimated ? 45 : 0))
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 3).repeatForever(autoreverses: true)
                    ) {
                        isAnimated.toggle()
                    }
                }
            )
    }
}

extension View {
    func animatedGradientBackground() -> some View {
        self.modifier(AnimatedGradientBackground())
    }
}
