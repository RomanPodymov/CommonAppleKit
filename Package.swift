// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonAppleKit",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .macOS(.v10_15)
    ],
    
    products: [
        .library(
            name: "CommonAppleKit",
            targets: ["CommonAppleKit"]
        ),
    ],
    
    dependencies: [],
    targets: [
        .target(
            name: "CommonAppleKit",
            dependencies: []
        ),
        .testTarget(
            name: "CommonAppleKitTests",
            dependencies: [
                .target(name: "CommonAppleKit")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
