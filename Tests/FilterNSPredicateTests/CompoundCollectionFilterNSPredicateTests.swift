// CompoundCollectionFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class CompoundCollectionFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
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
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
            ]
        )
    }

    func testAndNested() {
        let filter = CollectionFilter<[Int]>.or(
            .isIn([1]),
            .isIn([1, 2])
        )
        .and(
            .or(
                .isIn([1, 2, 3]),
                .isIn([1, 2, 3, 4])
            )
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
            ]
        )
    }

    func testAndMulti() {
        let filter = CollectionFilter<[Int]>.andMulti([
            .isIn([1]),
            .isIn([1, 2]),
            .isIn([1, 2, 3]),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
            ]
        )
    }

    func testAndMultiNested() {
        let filter = CollectionFilter<[Int]>.Compound.andMulti([
            .not(.isIn([1])),
            .not(.isIn([5])),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
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

    func testNot() {
        let filter = CollectionFilter<[Int]>.not(.isIn([5]))
        let result = values.filter(predicateType().build(from: filter))
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

    func testNotNested() {
        let filter = CollectionFilter<[Int]>.not(.isIn([5]))
            .not()
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [5],
            ]
        )
    }

    func testOr() {
        let filter = CollectionFilter<[Int]>.or(
            .isIn([1]),
            .isIn([5])
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [5],
            ]
        )
    }

    func testOrNested() {
        let filter = CollectionFilter<[Int]>.or(
            .isIn([1]),
            .isIn([5])
        )
        .or(
            .or(
                .isIn([1, 2]),
                .isIn([4, 5])
            )
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [4, 5],
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
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [5],
            ]
        )
    }

    func testOrMultiNested() {
        let filter = CollectionFilter<[Int]>.Compound.orMulti([
            .orMulti([
                .isIn([1]),
                .isIn([1, 2]),
                .isIn([1, 2, 3]),
            ]),
            .orMulti([
                .isIn([3, 4, 5]),
                .isIn([4, 5]),
                .isIn([5]),
            ]),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [1, 2, 3],
                [3, 4, 5],
                [4, 5],
                [5],
            ]
        )
    }

    func testPassthrough() {
        let filter = CompoundFilter<CollectionFilter<[Int]>>.passthrough(.isIn([1, 2]))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
            ]
        )
    }
}
