 [![CI Status](http://img.shields.io/travis/jgrandelli/URBNConvenience.svg?style=flat)](https://travis-ci.org/jgrandelli/URBNConvenience)
[![Version](https://img.shields.io/cocoapods/v/URBNConvenience.svg?style=flat)](http://cocoadocs.org/docsets/URBNConvenience)
[![License](https://img.shields.io/cocoapods/l/URBNConvenience.svg?style=flat)](http://cocoadocs.org/docsets/URBNConvenience)
[![Platform](https://img.shields.io/cocoapods/p/URBNConvenience.svg?style=flat)](http://cocoadocs.org/docsets/URBNConvenience)

# URBNConvenience

A collection of useful Categories, Macros, and convenience functions we use in URBN apps.

## Usage

URBNConvenience classes may be individually imported on an ass needed basis, or if you need all of them imported at once, you may import `URBNConvenience.h` which will bring with it all of the other classes currently in the URBNConvenience pod.

* __URBNConvenience:__ An umbrella framework header to be included when all URBNConvenience classes are needed. Also includes version information about URBNConvenience.

* __URBNFunctions:__ Convenience methods for things like app information, debug info, conversions, & async dispatching.

* __URBNMacros:__ Convenience macros for things like OS & device versions, logging, and assertions.

* __NSNotificationCenter+URBN:__ A category on NSNotificationCenter to remove the boiler plate around posting a notification on the main queue.

## Requirements

URBNConvenience has been tested on iOS 7 and up. Though it may work on lower deployment targets. ARC is required.

## Installation

URBNConvenience is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```
pod "URBNConvenience"
```

## License

URBNConvenience is available under the MIT license. See the LICENSE file for more info.

