// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "FileObserver", targets: ["FileObserver"]),
        .library(name: "AppGroupsFileSystem", targets: ["AppGroupsFileSystem"]),
        .library(name: "BroadcastPreferences", targets: ["BroadcastPreferences"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "FileObserver"),
        .target(name: "AppGroupsFileSystem", dependencies: ["FileObserver"]),
        .target(name: "BroadcastPreferences", dependencies: ["AppGroupsFileSystem"])
    ]
)
