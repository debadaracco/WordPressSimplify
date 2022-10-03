// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WordPressSimplify",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "WordPressSimplify",
            targets: ["WordPressSimplify"])
    ],
    targets: [
        .target(
            name: "WordPressSimplify",
            dependencies: [],
            path: "Source"
        ),
        .testTarget(
            name: "WordPressSimplify_Tests",
            dependencies: ["WordPressSimplify"],
            path: "Example/Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
