// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Colombo",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(
      name: "Colombo",
      targets: ["Colombo"]
    ),
  ],
  targets: [
    .target(
      name: "Colombo",
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
  ]
)
