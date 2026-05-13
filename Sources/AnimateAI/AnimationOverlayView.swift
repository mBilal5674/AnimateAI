//
//  AnimationOverlayView.swift
//  AnimateAI
//
//  Created by Muhammad Bilal on 13/05/2026.
//

import SwiftUI

// The actual animation that appears on screen
struct AnimationOverlayView: View {
    let config: AnimationConfig
    
    @State private var particles: [Particle] = []
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.5
    @State private var messageOffset: CGFloat = 50
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4 * opacity)
                .ignoresSafeArea()
                .onTapGesture { dismissAnimation() }
            
            // Particles
            ForEach(particles) { particle in
                ParticleView(particle: particle)
            }
            
            // Center message
            VStack(spacing: 16) {
                Text(config.message)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .scaleEffect(scale)
                    .offset(y: messageOffset)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        // Spawn particles
        particles = (0..<config.particleCount).map { _ in
            Particle(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: -100...UIScreen.main.bounds.height),
                color: Bool.random() ? config.primarySwiftUIColor : config.secondarySwiftUIColor,
                size: CGFloat.random(in: 6...16),
                rotation: Double.random(in: 0...360),
                animationType: config.type
            )
        }
        
        // Animate in
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            opacity = 1
            scale = 1
            messageOffset = 0
        }
        
        // Animate particles
        withAnimation(.easeOut(duration: config.duration)) {
            for i in particles.indices {
                particles[i].y += CGFloat.random(in: 200...500)
                particles[i].x += CGFloat.random(in: -100...100)
                particles[i].opacity = 0
            }
        }
        
        // Auto dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + config.duration + 0.5) {
            dismissAnimation()
        }
    }
    
    func dismissAnimation() {
        withAnimation(.easeOut(duration: 0.3)) {
            opacity = 0
            scale = 0.8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dismiss()
        }
    }
}

// Single particle
struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var color: Color
    var size: CGFloat
    var rotation: Double
    var opacity: Double = 1.0
    var animationType: AnimationConfig.AnimationType
}

struct ParticleView: View {
    let particle: Particle
    
    var shape: some View {
        Group {
            switch particle.animationType {
            case .celebration:
                Rectangle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size * 0.4)
                    .rotationEffect(.degrees(particle.rotation))
            case .success:
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
            case .error:
                Image(systemName: "xmark")
                    .foregroundColor(particle.color)
                    .font(.system(size: particle.size))
            case .onboarding:
                Image(systemName: "star.fill")
                    .foregroundColor(particle.color)
                    .font(.system(size: particle.size))
            case .loading:
                Circle()
                    .fill(particle.color.opacity(0.7))
                    .frame(width: particle.size * 0.5, height: particle.size * 0.5)
            }
        }
    }
    
    var body: some View {
        shape
            .position(x: particle.x, y: particle.y)
            .opacity(particle.opacity)
    }
}
