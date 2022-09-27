// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SP3Data",
    defaultLocalization: "en",
    products: [
        .library(
            name: "SP3Data",
            targets: ["SP3Data"]),
        .executable(
            name: "tool",
            targets: ["tool"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SP3Data",
            resources: [
                .process("Resources/Localization"),
                .copy("Resources/SP3AssetsPNG"),
                .copy("Resources/SP3ExtractedData"),
            ]),
        .testTarget(
            name: "SP3DataTest",
            dependencies: ["SP3Data"]),
        .executableTarget(
            name: "tool",
            dependencies: ["SP3Data"]),
    ]
)
