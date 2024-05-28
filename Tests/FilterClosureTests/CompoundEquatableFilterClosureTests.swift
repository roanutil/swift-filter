// CompoundEquatableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class CompoundEquatableFilterClosureTests: XCTestCase, ClosureTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    func testAnd() {
        let filter = EquatableFilter<Int>.and(
            .equalTo(1),
            .equalTo(4)
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [])
    }

    func testAndNested() {
        let filter = EquatableFilter<Int>.not(
            .equalTo(2)
        )
        .and(
            .not(.equalTo(4))
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [1, 3, 5]
        )
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

    func testAndMultiNested() {
        let filter = EquatableFilter<Int>.Compound.andMulti([
            .not(.equalTo(2)),
            .not(.equalTo(4)),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 3, 5])
    }

    func testNot() {
        let filter = EquatableFilter<Int>.not(.equalTo(1))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [2, 3, 4, 5])
    }

    func testNotNested() {
        let filter = EquatableFilter<Int>.not(.equalTo(1)).not()
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1])
    }

    func testOr() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(1),
            .equalTo(4)
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 4])
    }

    func testOrNested() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(1),
            .equalTo(3)
        )
        .or(
            .not(.equalTo(4))
        )
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(
            result,
            [1, 2, 3, 5]
        )
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

    func testOrMultiNested() {
        let filter = EquatableFilter<Int>.Compound.orMulti([
            .not(.equalTo(2)),
            .not(.equalTo(4)),
        ])
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }

    func testPassthrough() {
        let filter = CompoundFilter<ComparableFilter<Int>>.passthrough(.equalTo(3))
        let result = values.filter(predicateType().build(from: filter))
        XCTAssertEqual(result, [3])
    }
}
