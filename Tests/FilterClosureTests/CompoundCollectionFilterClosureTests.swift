// CompoundCollectionFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class CompoundCollectionFilterClosureTests: XCTestCase {
    let values: [[Int]] = [
        [1],
        [1, 2],
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
        [2, 3, 4, 5],
        [3, 4, 5],
        [4, 5],
        [5],
    ]

    func testAnd() {
        let filter = CollectionFilter<[Int]>.and(
            .isIn([1]),
            .isIn([1, 2])
        )
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
            ]
        )
    }

    func testAndMulti() {
        let filter = CollectionFilter<[Int]>.andMulti([
            .isIn([1]),
            .isIn([1, 2]),
            .isIn([1, 2, 3]),
        ])
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
            ]
        )
    }

    func testNot() {
        let filter = CollectionFilter<[Int]>.not(.isIn([5]))
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5],
                [3, 4, 5],
                [4, 5],
            ]
        )
    }

    func testOr() {
        let filter = CollectionFilter<[Int]>.or(
            .isIn([1]),
            .isIn([5])
        )
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [5],
            ]
        )
    }

    func testOrMulti() {
        let filter = CollectionFilter<[Int]>.orMulti([
            .isIn([1]),
            .isIn([1, 2]),
            .isIn([5]),
        ])
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [5],
            ]
        )
    }

    func testPassthrough() {
        let filter = CompoundFilter<CollectionFilter<[Int]>>.passthrough(.isIn([1, 2]))
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
            ]
        )
    }
}
