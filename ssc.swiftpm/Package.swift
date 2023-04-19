// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ssc",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "ssc",
            targets: ["AppModule"],
            bundleIdentifier: "ssc.ssc",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .note),
            accentColor: .presetColor(.yellow),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/musical77/MusicalInstrument.git", .branch("main")),
//        .package(url: "https://github.com/cemolcay/MusicTheory.git", "1.0.0"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "MusicalInstrument", package: "musicalinstrument"),
//                .product(name: "MusicTheory", package: "musictheory")
            ],
            path: "."
        )
    ]
)
