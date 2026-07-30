// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WakTrainerCoreModels",
    // iOS 13 이상 지원 명시
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WakTrainerCoreModels",
            targets: ["WakTrainerCoreModels"]
        ),
    ],
    dependencies: [
        // 단독 모듈이므로 의존성 없음
    ],
    targets: [
        .target(
            name: "WakTrainerCoreModels",
            dependencies: []
        ),
        .testTarget(
            name: "WakTrainerCoreModelsTests",
            dependencies: ["WakTrainerCoreModels"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
