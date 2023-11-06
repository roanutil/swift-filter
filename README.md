# swift-filter

[![CI](https://github.com/roanutil/swift-filter/actions/workflows/ci.yml/badge.svg)](https://github.com/roanutil/swift-filter/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/roanutil/swift-filter/branch/main/graph/badge.svg?token=86G7F92SM2)](https://codecov.io/gh/roanutil/swift-filter)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Froanutil%2Fswift-filter%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/roanutil/swift-filter)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Froanutil%2Fswift-filter%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/roanutil/swift-filter)

Filter is a library that makes it easy to model filters in state and then create predicates from that state.

## Included Products

- Filter
- FilterClosure
- FilterNSPredicate

## Filter

### [Documentation](https://swiftpackageindex.com/roanutil/swift-filter/documentation/filter)

Core library that supports filter modeling and protocols for predicates.

FilterClosure and FilterNSPredicate provide good examples of implementing the predicate protocols.

### Example

```swift
let filter = ComparableFilter<Date>.andMulti([
    .greaterThanOrEqualTo(Date.distantPast),
    .equatable(.not(.equalTo(Date.now))),
    .lessThanOrEqualTo(Date.distantFuture)
])
let nsPredicate = NSPredicate.build(from: filter)
let closure = Closure.build(from: filter)
let dates: [Date] = (Int.zero...Int.max).map { Date(timeIntervalSince1970: Double($0)) }
let filteredByClosure = dates.filter(closure)
let filteredByNSPredicate = dates.filter { nsPredicate.evaluate(with: $0) }
```

## FilterClosure

### [Documentation](https://swiftpackageindex.com/roanutil/swift-filter/documentation/filterclosure)

Implementations of strongly typed predicate protocols that produce closures for filtering

## FilterNSPredicate

### [Documentation](https://swiftpackageindex.com/roanutil/swift-filter/documentation/filternspredicate)

Implementation of type erased predicate protocols that produce `NSPredicate`s.

## Installation

Add Filter to your Xcode project with Swift Package Manager.

Use the https URL from this repository in the Xcode Swift Packages dialogue or package manifest.
