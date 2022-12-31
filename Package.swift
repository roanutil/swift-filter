// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "swift-filter",
    products: [
        .library(
            name: "Filter",
            targets: ["Filter"]
        ),
        .library(
            name: "FilterNSPredicate",
            targets: ["FilterNSPredicate"]
        ),
        .library(
            name: "FilterClosure",
            targets: ["FilterClosure"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Filter",
            dependencies: []
        ),
        .testTarget(
            name: "FilterClosureTests",
            dependencies: ["FilterClosure"]
        ),
        .testTarget(
            name: "FilterNSPredicateTests",
            dependencies: ["FilterNSPredicate"]
        ),
        .target(
            name: "FilterNSPredicate",
            dependencies: [
                "Filter",
            ]
        ),
        .target(
            name: "FilterClosure",
            dependencies: [
                "Filter",
            ]
        ),
    ]
)
