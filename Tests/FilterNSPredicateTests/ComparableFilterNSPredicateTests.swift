// ComparableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

// ComparableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class ComparableFilterNSPredicateTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    func testEquatable() {
        let filter = ComparableFilter<Int>.equatable(.equalTo(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3])
    }

    func testGreaterThan() {
        let filter = ComparableFilter<Int>.greaterThan(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [4, 5])
    }

    func testGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.greaterThanOrEqualTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3, 4, 5])
    }

    func testLessThan() {
        let filter = ComparableFilter<Int>.lessThan(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 2])
    }

    func testLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.lessThanOrEqualTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 2, 3])
    }
}
