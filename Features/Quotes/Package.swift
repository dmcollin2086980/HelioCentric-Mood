// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Quotes",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Quotes",
            targets: ["Quotes"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/DesignSystem"),
        .package(path: "../../Shared/Core"),
        .package(path: "../../Shared/Data")
    ],
    targets: [
        .target(
            name: "Quotes",
            dependencies: [
                "DesignSystem",
                "Core",
                "Data"
            ]
        ),
        .testTarget(
            name: "QuotesTests",
            dependencies: ["Quotes"]
        ),
    ]
)
