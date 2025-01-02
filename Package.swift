// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Piano3",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "Piano3",
            targets: ["Piano3"]
        ),
    ],
    targets: [
        .target(
            name: "Piano3",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "Piano3Tests",
            dependencies: ["Piano3"]
        ),
    ]
)