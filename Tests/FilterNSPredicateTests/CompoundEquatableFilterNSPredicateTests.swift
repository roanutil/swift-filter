// CompoundEquatableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class CompoundEquatableFilterNSPredicateTests: XCTestCase, NSPredicateTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    func testAnd() {
        let filter = EquatableFilter<Int>.and(
            .equalTo(1),
            .equalTo(4)
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [])
    }

    func testAndMulti() {
        let filter = EquatableFilter<Int>.andMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [])
    }

    func testNot() {
        let filter = EquatableFilter<Int>.not(.equalTo(1))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [2, 3, 4, 5])
    }

    func testOr() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(1),
            .equalTo(4)
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 4])
    }

    func testOrMulti() {
        let filter = EquatableFilter<Int>.orMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 4, 5])
    }

    func testPassthrough() {
        let filter = CompoundFilter<ComparableFilter<Int>>.passthrough(.equalTo(3))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [3])
    }
}
