// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Piano3",
    platforms: [
        .iOS(.v13),
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
            dependencies: []
        ),
        .testTarget(
            name: "Piano3Tests",
            dependencies: ["Piano3"]
        ),
    ]
)