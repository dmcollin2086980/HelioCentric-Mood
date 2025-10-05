// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Mood",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Mood",
            targets: ["Mood"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/DesignSystem"),
        .package(path: "../../Shared/Core"),
        .package(path: "../../Shared/Data")
    ],
    targets: [
        .target(
            name: "Mood",
            dependencies: [
                "DesignSystem",
                "Core",
                "Data"
            ]
        ),
        .testTarget(
            name: "MoodTests",
            dependencies: ["Mood"]
        ),
    ]
)
