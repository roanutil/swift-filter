// swift-tools-version:5.5

import PackageDescription

var products: [Product] = [
    .library(
        name: "Filter",
        targets: ["Filter"]
    ),
    .library(
        name: "FilterClosure",
        targets: ["FilterClosure"]
    ),
]

var targets: [Target] = [
    .target(name: "Filter"),
    .target(
        name: "FilterClosure",
        dependencies: [
            "Filter",
        ]
    ),
    .testTarget(
        name: "FilterClosureTests",
        dependencies: [
            "FilterClosure",
        ]
    ),
]

#if !os(Linux) && !os(Windows)
    products.append(.library(
        name: "FilterNSPredicate",
        targets: ["FilterNSPredicate"]
    ))

    targets.append(contentsOf: [
        .target(
            name: "FilterNSPredicate",
            dependencies: [
                "Filter",
            ]
        ),
        .testTarget(
            name: "FilterNSPredicateTests",
            dependencies: [
                "FilterNSPredicate",
            ]
        ),
    ])
#endif

let package = Package(
    name: "swift-filter",
    products: products,
    targets: targets
)
