// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrckTesting",
    dependencies: [
      .package(url: "../../../", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "TrckTesting",
            dependencies: ["Trck"]),
        .testTarget(
            name: "TrckTestingTests",
            dependencies: ["Trck"]),
        .testTarget(
            name: "TrckTestingUITests",
            dependencies: ["Trck"]),
    ]
)
