// OptionalCompoundSequenceFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

class OptionalCompoundSequenceFilterClosureTests: XCTestCase {
    let all: [[Int]?] = [
        [1],
        nil,
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Sequence

    func testIsNil() {
        let filter = SequenceFilter<[Int]>.contains(5).not().isNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [nil]
        )
    }

    func testNotNil() {
        let filter = SequenceFilter<[Int]>.contains(5).not().notNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2, 3],
                [1, 2, 3, 4],
            ]
        )
    }

    func testOrNil() {
        let filter = SequenceFilter<[Int]>.contains(5).not().orNil()
        let result = all.filter(Closure.build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [
                [1],
                nil,
                [1, 2, 3],
                [1, 2, 3, 4],
            ]
        )
    }
}
