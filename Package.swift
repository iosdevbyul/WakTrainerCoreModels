// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WakTrainerCoreModels",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(name: "WakTrainerCoreModels", targets: ["WakTrainerCoreModels"])
    ],
    targets: [
        .target(name: "WakTrainerCoreModels"),
        .testTarget(
            name: "WakTrainerCoreModelsTests",
            dependencies: ["WakTrainerCoreModels"]
        )
    ]
)
