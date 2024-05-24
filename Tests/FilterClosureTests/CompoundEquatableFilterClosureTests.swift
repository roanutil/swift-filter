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

final class CompoundEquatableFilterClosureTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    func testAnd() {
        let filter = EquatableFilter<Int>.and(
            .equalTo(1),
            .equalTo(4)
        )
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [])
    }

    func testAndMulti() {
        let filter = EquatableFilter<Int>.andMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ])
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [])
    }

    func testNot() {
        let filter = EquatableFilter<Int>.not(.equalTo(1))
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [2, 3, 4, 5])
    }

    func testOr() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(1),
            .equalTo(4)
        )
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [1, 4])
    }

    func testOrMulti() {
        let filter = EquatableFilter<Int>.orMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ])
        let result = all.filter(Closure.build(from: filter))
        XCTAssertEqual(result, [1, 4, 5])
    }
}
