// WakTrainerCoreModels / Package.swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "WakTrainerCoreModels",
    platforms: [
        .iOS(.v13),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "WakTrainerCoreModels",
            targets: ["WakTrainerCoreModels"]
        ),
    ],
    targets: [
        .target(
            name: "WakTrainerCoreModels"
        ),
        .testTarget(
            name: "WakTrainerCoreModelsTests",
            dependencies: ["WakTrainerCoreModels"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
