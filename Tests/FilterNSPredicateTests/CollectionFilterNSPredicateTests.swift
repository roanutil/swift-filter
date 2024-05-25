// CollectionFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class CollectionFilterNSPredicateTests: XCTestCase {
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
        let result = all.filter(NSPredicate.build(from: filter).closure)
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
        let result = all.filter(NSPredicate.build(from: filter).closure)
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
