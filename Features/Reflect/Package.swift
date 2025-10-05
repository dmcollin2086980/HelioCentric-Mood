// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Reflect",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Reflect",
            targets: ["Reflect"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/DesignSystem"),
        .package(path: "../../Shared/Core"),
        .package(path: "../../Shared/Data")
    ],
    targets: [
        .target(
            name: "Reflect",
            dependencies: [
                "DesignSystem",
                "Core",
                "Data"
            ]
        ),
        .testTarget(
            name: "ReflectTests",
            dependencies: ["Reflect"]
        ),
    ]
)
