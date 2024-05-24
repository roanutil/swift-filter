// EquatableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

final class EquatableFilterClosureTests: XCTestCase {
    let values: [Int] = [1, 2, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter<Int>.equalTo(3)
        let result = values.filter(Closure<Int, Int>.build(from: filter))
        XCTAssertEqual(result, [3])
    }
}
