// OptionalCompoundComparableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

// final class OptionalCompoundComparableFilterNSPredicateTests: XCTestCase {
//    let values: [Int?] = [1, nil, 3, 4, 5]
//
//    func testIsNil() {
//        let filter = ComparableFilter<Int>.lessThan(3).not().isNil()
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [nil])
//    }
//
//    func testNotNil() {
//        let filter = ComparableFilter<Int>.lessThan(3).not().notNil()
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [3, 4, 5])
//    }
//
//    func testOrNil() {
//        let filter = ComparableFilter<Int>.lessThan(3).not().orNil()
//        let result = values.filter(NSPredicate.build(from: filter, on: \Int?.self).closure)
//        XCTAssertEqual(result, [nil, 3, 4, 5])
//    }
// }
