// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PulsarButton",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "PulsarButton",
            targets: ["PulsarButton"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PulsarButton",
            dependencies: []),
        .testTarget(
            name: "PulsarButtonTests",
            dependencies: ["PulsarButton"]),
    ]
)
