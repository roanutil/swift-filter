// OptionalSequenceFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class OptionalSequenceFilterClosureTests: XCTestCase {
    let all: [[Int]?] = [
        [1],
        nil,
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Sequence

    func testIsNil() {
        let filter = SequenceFilter<[Int]>.contains(5).isNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(result, [nil])
    }

    func testNotNil() {
        let filter = SequenceFilter<[Int]>.contains(5).notNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(result, [[1, 2, 3, 4, 5]])
    }

    func testOrNil() {
        let filter = SequenceFilter<[Int]>.contains(5).orNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(result, [nil, [1, 2, 3, 4, 5]])
    }
}
