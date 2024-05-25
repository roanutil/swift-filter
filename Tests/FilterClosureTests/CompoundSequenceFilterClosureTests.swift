// CompoundSequenceFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class CompoundSequenceFilterClosureTests: XCTestCase {
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
        let filter = SequenceFilter<[Int]>.and(
            .contains(3),
            .contains(5)
        )
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5],
                [3, 4, 5],
            ]
        )
    }

    func testAndMulti() {
        let filter = SequenceFilter<[Int]>.andMulti([
            .contains(2),
            .contains(3),
            .contains(5),
        ])
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5],
            ]
        )
    }

    func testNot() {
        let filter = SequenceFilter<[Int]>.not(.contains(3))
        let result = values.filter(Closure.build(from: filter))
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

    func testOr() {
        let filter = SequenceFilter<[Int]>.or(
            .contains(3),
            .contains(5)
        )
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5],
                [3, 4, 5],
                [4, 5],
                [5],
            ]
        )
    }

    func testOrMulti() {
        let filter = SequenceFilter<[Int]>.orMulti([
            .contains(1),
            .contains(2),
            .contains(3),
        ])
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
            ]
        )
    }

    func testPassthrough() {
        let filter = CompoundFilter<SequenceFilter<[Int]>>.passthrough(.contains(3))
        let result = values.filter(Closure.build(from: filter))
        XCTAssertEqual(
            result,
            [
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
                [2, 3, 4, 5],
                [3, 4, 5],
            ]
        )
    }
}
