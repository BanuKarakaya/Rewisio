// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SharedCore",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SharedCore",
            targets: ["SharedCore"]
        )
    ],
    targets: [
        .target(
            name: "SharedCore",
            dependencies: []
        )
    ]
)

