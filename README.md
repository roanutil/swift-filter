# SwiftFilter

[![CI](https://github.com/roanutil/SwiftFilter/actions/workflows/ci.yml/badge.svg)](https://github.com/roanutil/SwiftFilter/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/roanutil/SwiftFilter/branch/main/graph/badge.svg?token=86G7F92SM2)](https://codecov.io/gh/roanutil/SwiftFilter)

SwiftFilter is a library that makes it easy to model filters in state and then create predicates from that state.

## Included Products
- SwiftFilter
- SwiftFilterClosure
- SwiftFilterNSPredicate

## SwiftFilter
Core library that supports filter modeling and protocols for predicates.

SwiftFilterClosure and SwiftFilterNSPredicate provide good examples of implementing the predicate protocols.

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

## SwiftFilterClosure
Implementations of strongly typed predicate protocols that produce closures for filtering

## SwiftFilterNSPredicate
Implementation of type erased predicate protocols that produce `NSPredicate`s.

## Installation
Add SwiftFilter to your Xcode project with Swift Package Manager.

Use the https URL from this repository in the Xcode Swift Packages dialogue or package manifest.
