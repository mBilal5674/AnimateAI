# AnimateAI for iOS

One line of code. Beautiful AI-generated animations.

AnimateAI is an open source Swift Package that uses Claude AI to generate beautiful, context-aware animations for any iOS app — no animation knowledge needed.

## Installation

In Xcode, go to File > Add Package Dependencies and enter:
https://github.com/mBilal5674/AnimateAI

## Setup

Import and configure once in your app:

    import AnimateAI
    AnimateAI.configure(apiKey: "YOUR_ANTHROPIC_API_KEY")

## Usage

    AnimateAI.show(prompt: "user just completed their first purchase")
    AnimateAI.show(prompt: "payment failed")
    AnimateAI.show(prompt: "brand new user opening app for first time")
    AnimateAI.show(prompt: "user just hit 10,000 steps today")

## How It Works
1. You pass a plain English prompt
2. AnimateAI sends it to Claude AI
3. Claude returns animation config with colors, intensity, particles
4. AnimateAI renders a beautiful SwiftUI animation instantly

## Animation Types
- Celebration — achievements, purchases, milestones
- Success — completions, confirmations
- Error — failures, declines, problems
- Loading — waiting, processing states
- Onboarding — first time experiences

## Requirements
- iOS 16+
- Xcode 14+
- Anthropic API key from console.anthropic.com

## Demo App
github.com/mBilal5674/AnimateAIDemoApp

## Built By
Muhammad Bilal — Principal iOS Engineer
LinkedIn: linkedin.com/in/muhammad-bilal-165029b3
GitHub: github.com/mBilal5674

## License
MIT
