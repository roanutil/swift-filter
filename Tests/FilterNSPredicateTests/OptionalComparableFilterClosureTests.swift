// OptionalComparableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

// final class OptionalComparableFilterNSPredicateTests: XCTestCase {
//    let values: [Int?] = [1, nil, 3, 4, 5]
//
//    func testIsNil() {
//        let filter = ComparableFilter<Int>.isNil()
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [nil])
//    }
//
//    func testNotNil() {
//        let filter = ComparableFilter<Int>.notNil(nil)
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [1, 3, 4, 5])
//    }
//
//    func testOrNil() {
//        let filter = ComparableFilter<Int>.orNil(.lessThan(5))
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [1, nil, 3, 4])
//    }
// }
