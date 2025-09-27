// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-webp",
    products: [
        .library(
            name: "WebP",
            targets: ["WebP"]
        ),
    ],
    targets: [
        .target(
            name: "WebP",
            dependencies: ["CWebP"]
        ),
        .systemLibrary(
            name: "CWebP",
            pkgConfig: "libwebp",
            providers: [.brew(["webp"]), .apt(["webp"])]
        ),
        .testTarget(
            name: "WebPTests",
            dependencies: ["WebP"],
            resources: [.copy("Nærøyfjorden, Norway - from Breiskrednosi. UNESCO World Heritage.webp")]
        ),
    ]
)
