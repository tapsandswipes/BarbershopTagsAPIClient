// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "BarbershopTagsAPIClient",
    platforms: [.iOS(.v13), .macOS(.v12)],
    products: [
        .library(
            name: "BarbershopTagsAPIClient",
            targets: ["BarbershopTagsAPIClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tapsandswipes/XMLCoder.git", branch: "main"),
        .package(url: "https://github.com/tapsandswipes/Chainable", branch: "main"),
    ],
    targets: [
        .target(
            name: "BarbershopTagsAPIClient",
            dependencies: [
                "XMLCoder",
                "Chainable",
            ]
        ),
        .testTarget(
            name: "BarbershopTagsAPIClientTests",
            dependencies: [
                "BarbershopTagsAPIClient",
                "XMLCoder",
            ], 
            resources: [
                .copy("tag54.xml"),
                .copy("tags.xml"),
            ]
        ),
    ]
)
