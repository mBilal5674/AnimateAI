// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AnimateAI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AnimateAI",
            targets: ["AnimateAI"]
        ),
    ],
    targets: [
        .target(
            name: "AnimateAI",
            path: "Sources/AnimateAI"
        ),
        .testTarget(
            name: "AnimateAITests",
            dependencies: ["AnimateAI"],
            path: "Tests/AnimateAITests"
        ),
    ]
)
