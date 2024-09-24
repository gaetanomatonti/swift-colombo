import ProjectDescription

let colombo: Target = .target(
  name: "Colombo",
  destinations: .iOS,
  product: .framework,
  bundleId: "com.gaetanomatonti.swift-colombo",
  deploymentTargets: .iOS("17.0"),
  sources: [
    .glob(
      .relativeToRoot("Colombo/Sources/**")
    )
  ]
)

let demoApp: Target = .target(
  name: "ColomboDemo",
  destinations: .iOS,
  product: .app,
  bundleId: "com.gaetanomatonti.swift-colombo-demo",
  deploymentTargets: .iOS("17.0"),
  infoPlist: .extendingDefault(
    with: [
      "UILaunchScreen": [
        "UIColorName": "",
        "UIImageName": "",
      ],
    ]
  ),
  sources: [
    "ColomboDemo/Sources/**"
  ],
  resources: [
    "ColomboDemo/Resources/**"
  ],
  dependencies: [
    .target(name: "Colombo")
  ]
)

let project = Project(
  name: "ColomboDemo",
  options: .options(
    disableBundleAccessors: true,
    textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2)
  ),
  settings: .settings(
    base: [
      "SWIFT_STRICT_CONCURRENCY": "complete",
      "SWIFT_VERSION": "6",
    ]
  ),
  targets: [
    demoApp,
    colombo,
  ],
  resourceSynthesizers: []
)
