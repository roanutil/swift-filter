// OptionalCompoundEquatableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class OptionalCompoundEquatableFilterClosureTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    func testIsNil() {
        let filter = EquatableFilter<Int>.not(.equalTo(3)).isNil()
        let result = allOptional.filter(Closure.build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [nil])
    }

    func testNotNil() {
        let filter = EquatableFilter<Int>.not(.equalTo(3)).notNil()
        let result = allOptional.filter(Closure.build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [1, 4, 5])
    }

    func testOrNil() {
        let filter = EquatableFilter<Int>.not(.equalTo(3)).orNil()
        let result = allOptional.filter(Closure.build(from: filter, on: \Int?.self))
        XCTAssertEqual(result, [1, nil, 4, 5])
    }
}
