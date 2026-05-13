//
//  AnimationPresenter.swift
//  AnimateAI
//
//  Created by Muhammad Bilal on 13/05/2026.
//

import SwiftUI
import UIKit

// Presents the animation over any app
@MainActor
class AnimationPresenter {
    
    static func present(config: AnimationConfig) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let hostingController = UIHostingController(
            rootView: AnimationOverlayView(config: config)
                .ignoresSafeArea()
        )
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        
        window.rootViewController?.present(hostingController, animated: false)
    }
}
