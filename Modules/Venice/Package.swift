import PackageDescription

let package = Package(
    name: "Venice",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Core.git", majorVersion: 0, minor: 13),
        .Package(url: "https://github.com/Zewo/CLibvenice.git", majorVersion: 0, minor: 13),
    ]
)
