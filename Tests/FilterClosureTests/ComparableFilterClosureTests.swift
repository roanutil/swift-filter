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
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Comparable

    func testLessThan() {
        let filter = ComparableFilter<Int>.lessThan(3)
        let result = all.filter(Closure.buildComparable(from: filter))
        XCTAssertEqual(result, [1, 2])
    }

    func testGreaterThan() {
        let filter = ComparableFilter<Int>.greaterThan(3)
        let result = all.filter(Closure.buildComparable(from: filter))
        XCTAssertEqual(result, [4, 5])
    }

    func testLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.lessThanOrEqualTo(3)
        let result = all.filter(Closure.buildComparable(from: filter))
        XCTAssertEqual(result, [1, 2, 3])
    }

    func testGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.greaterThanOrEqualTo(3)
        let result = all.filter(Closure.buildComparable(from: filter))
        XCTAssertEqual(result, [3, 4, 5])
    }

    func testOrMulti() {
        let filter = ComparableFilter<Int>.orMulti([
            .lessThan(2),
            .greaterThanOrEqualTo(4),
        ])
        let result = all.filter(Closure.buildCompound(from: filter))
        XCTAssertEqual(result, [1, 4, 5])
    }
}
