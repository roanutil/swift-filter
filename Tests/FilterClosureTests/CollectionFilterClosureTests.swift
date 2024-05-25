// CollectionFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class CollectionFilterClosureTests: XCTestCase {
    let all: [[Int]] = [
        [1],
        [1, 2],
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Collection

    func testIsIn() {
        let filter = CollectionFilter<[Int]>.isIn([1, 2, 3])
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [1, 2, 3],
            ]
        )
    }

    func testSequence() {
        let filter = CollectionFilter<[Int]>.sequence(.contains(3))
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }
}
