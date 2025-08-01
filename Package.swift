// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UUIDv7",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UUIDv7",
            targets: ["UUIDv7"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UUIDv7"),
        .testTarget(
            name: "UUIDv7Tests",
            dependencies: ["UUIDv7"]
        ),
    ]
)
