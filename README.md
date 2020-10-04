
# NoThemeForPublish

NoThemeForPublish is a very very minimal [Publish](https://github.com/johnsundell/publish) theme without any headers, footers, menu etc.

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/l1ghthouse/NoThemeForPublish.git", from: "0.1.6")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "NoThemeForPublish"
            ]
        )
    ]
    ...
)
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

The theme can then be used within any publishing pipeline like this:

```swift
import NoThemeForPublish
...
try YourSite().publish(withTheme: .notheme)
```
