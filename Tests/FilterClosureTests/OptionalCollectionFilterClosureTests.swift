// OptionalCollectionFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class OptionalCollectionFilterClosureTests: XCTestCase, ClosureTestCase {
    let values: [[Int]?] = [
        [1],
        nil,
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Collection

    func testIsNil() {
        let filter = CollectionFilter<[Int]>.isIn([1, 2, 3]).isNil()
        let result = values.filter(predicateType().build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [nil]
        )
    }

    func testNotNil() {
        let filter = CollectionFilter<[Int]>.isIn([1, 2, 3]).notNil()
        let result = values.filter(predicateType().build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2, 3],
            ]
        )
    }

    func testOrNil() {
        let filter = CollectionFilter<[Int]>.isIn([1, 2, 3]).orNil()
        let result = values.filter(predicateType().build(from: filter, on: \.self))
        XCTAssertEqual(
            result,
            [
                [1],
                nil,
                [1, 2, 3],
            ]
        )
    }
}
