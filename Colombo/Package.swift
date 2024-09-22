// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Colombo",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(
      name: "Colombo",
      targets: ["Colombo"]
    ),
  ],
  targets: [
    .target(
      name: "Colombo"
    ),
  ]
)
