// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Journal",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Journal",
            targets: ["Journal"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/DesignSystem"),
        .package(path: "../../Shared/Core"),
        .package(path: "../../Shared/Data")
    ],
    targets: [
        .target(
            name: "Journal",
            dependencies: [
                "DesignSystem",
                "Core",
                "Data"
            ]
        ),
        .testTarget(
            name: "JournalTests",
            dependencies: ["Journal"]
        ),
    ]
)
