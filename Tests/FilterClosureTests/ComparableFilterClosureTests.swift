// ComparableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class ComparableFilterClosureTests: XCTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    // MARK: Comparable

    func testEquatable() {
        let filter = ComparableFilter<Int>.equatable(.equalTo(3))
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [3])
    }

    func testGreaterThan() {
        let filter = ComparableFilter<Int>.greaterThan(3)
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [4, 5])
    }

    func testGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.greaterThanOrEqualTo(3)
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [3, 4, 5])
    }

    func testLessThan() {
        let filter = ComparableFilter<Int>.lessThan(3)
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [1, 2])
    }

    func testLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.lessThanOrEqualTo(3)
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [1, 2, 3])
    }
}
