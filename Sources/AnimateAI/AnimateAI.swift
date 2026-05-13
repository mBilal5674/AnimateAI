// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

// MARK: - Main AnimateAI Entry Point
// Developers just write: AnimateAI.show(prompt: "celebrate a win")

@MainActor
public class AnimateAI {
    
    private static var apiKey: String = ""
    
    // Developer sets their API key once
    public static func configure(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // Main function — show animation from prompt
    public static func show(
        prompt: String,
        in view: UIViewController? = nil
    ) async {
        guard !apiKey.isEmpty else {
            print("⚠️ AnimateAI: Please call AnimateAI.configure(apiKey:) first")
            return
        }
        
        // Get animation config from Claude
        let service = AnimateAIService(apiKey: apiKey)
        if let config = await service.generateConfig(for: prompt) {
            await MainActor.run {
                AnimationPresenter.present(config: config)
            }
        }
    }
}
