// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFilter",
    products: [
        .library(
            name: "SwiftFilter",
            targets: ["SwiftFilter"]
        ),
        .library(
            name: "SwiftFilterNSPredicate",
            targets: ["SwiftFilterNSPredicate"]
        ),
        .library(
            name: "SwiftFilterClosure",
            targets: ["SwiftFilterClosure"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftFilter",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftFilterClosureTests",
            dependencies: ["SwiftFilterClosure"]
        ),
        .testTarget(
            name: "SwiftFilterNSPredicateTests",
            dependencies: ["SwiftFilterNSPredicate"]
        ),
        .target(
            name: "SwiftFilterNSPredicate",
            dependencies: [
                "SwiftFilter",
            ]
        ),
        .target(
            name: "SwiftFilterClosure",
            dependencies: [
                "SwiftFilter",
            ]
        ),
    ]
)
