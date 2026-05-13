//
//  AnimateAIService.swift
//  AnimateAI
//
//  Created by Muhammad Bilal on 13/05/2026.
//

import Foundation

// Calls Claude API and gets animation config back as JSON
class AnimateAIService {
    
    private let apiKey: String
    private let apiURL = "https://api.anthropic.com/v1/messages"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func generateConfig(for prompt: String) async -> AnimationConfig? {
        guard let url = URL(string: apiURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        
        let systemPrompt = """
        You are an animation configuration generator for iOS apps.
        
        When given a description, return ONLY a valid JSON object with these exact fields:
        {
            "type": "celebration" | "success" | "error" | "loading" | "onboarding",
            "primaryColor": "#HEXCODE",
            "secondaryColor": "#HEXCODE",
            "intensity": 0.0 to 1.0,
            "duration": 1.0 to 4.0,
            "particleCount": 20 to 150,
            "message": "short emoji + message"
        }
        
        Rules:
        - celebration: confetti, happy colors like gold/orange/pink
        - success: checkmark feel, greens and teals
        - error: attention needed, reds and oranges  
        - loading: calm, blues and purples
        - onboarding: welcoming, gradients, warm colors
        - Match intensity to the emotion strength
        - ONLY return JSON, no explanation, no markdown
        """
        
        let body: [String: Any] = [
            "model": "claude-sonnet-4-6",
            "max_tokens": 500,
            "system": systemPrompt,
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let content = json["content"] as? [[String: Any]],
                  let text = content.first?["text"] as? String else {
                return nil
            }
            
            // Parse JSON response from Claude
            let cleanText = text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: "```json", with: "")
                .replacingOccurrences(of: "```", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard let configData = cleanText.data(using: .utf8) else { return nil }
            let config = try JSONDecoder().decode(AnimationConfig.self, from: configData)
            return config
            
        } catch {
            print("AnimateAI Error: \(error)")
            return nil
        }
    }
}
