// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TimelineSchedule",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TimelineSchedule",
            targets: ["TimelineSchedule"]),
    ],
    targets: [
        .target(
            name: "TimelineSchedule",
            dependencies: [],
            path: "Sources/TimelineSchedule"),
        .testTarget(
            name: "TimelineScheduleTests",
            dependencies: ["TimelineSchedule"],
            path: "Tests/TimelineScheduleTests"),
    ]
)
