// CompoundComparableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class CompoundComparableFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    func testAnd() {
        let filter = ComparableFilter<Int>.and(
            .lessThan(4),
            .greaterThan(2)
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [3])
    }

    func testAndNested() {
        let filter = ComparableFilter<Int>.or(
            .lessThan(3),
            .greaterThan(3)
        )
        .and(
            .or(
                .lessThan(2),
                .greaterThan(4)
            )
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [1, 5]
        )
    }

    func testAndMulti() {
        let filter = ComparableFilter<Int>.andMulti([
            .lessThanOrEqualTo(5),
            .greaterThanOrEqualTo(1),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }

    func testAndMultiNested() {
        let filter = ComparableFilter<Int>.Compound.andMulti([
            .or(
                .lessThan(3),
                .greaterThan(3)
            ),
            .or(
                .lessThan(2),
                .greaterThan(4)
            ),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [1, 5]
        )
    }

    func testNot() {
        let filter = ComparableFilter<Int>.not(.greaterThan(3))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 2, 3])
    }

    func testNotNested() {
        let filter = ComparableFilter<Int>.Compound.not(.not(.greaterThan(3)))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [4, 5])
    }

    func testOr() {
        let filter = ComparableFilter<Int>.or(
            .equatable(.equalTo(1)),
            .equatable(.equalTo(4))
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 4])
    }

    func testOrNested() {
        let filter = ComparableFilter<Int>.or(
            .lessThan(3),
            .greaterThan(3)
        )
        .or(
            .or(
                .lessThan(2),
                .greaterThan(4)
            )
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [1, 2, 4, 5]
        )
    }

    func testOrMulti() {
        let filter = ComparableFilter<Int>.orMulti([
            .lessThanOrEqualTo(2),
            .equatable(.equalTo(3)),
            .greaterThanOrEqualTo(4),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }

    func testOrMultiNested() {
        let filter = ComparableFilter<Int>.Compound.orMulti([
            .and(
                .lessThan(3),
                .greaterThan(1)
            ),
            .and(
                .lessThan(5),
                .greaterThan(3)
            ),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [2, 4])
    }

    func testPassthrough() {
        let filter = CompoundFilter<ComparableFilter<Int>>.passthrough(.lessThan(3))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 2])
    }
}
