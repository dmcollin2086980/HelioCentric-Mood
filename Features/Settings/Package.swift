// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/DesignSystem"),
        .package(path: "../../Shared/Core"),
        .package(path: "../../Shared/Data")
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                "DesignSystem",
                "Core",
                "Data"
            ]
        ),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]
        ),
    ]
)
