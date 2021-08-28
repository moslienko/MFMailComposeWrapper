// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MFMailComposeWrapper",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "MFMailComposeWrapper",
            targets: ["MFMailComposeWrapper"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MFMailComposeWrapper",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "MFMailComposeWrapperTests",
            dependencies: ["MFMailComposeWrapper"],
            path: "Tests"
        ),
    ]
)
