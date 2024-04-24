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
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter.equalTo(3)
        let result = all.filter(Closure.buildEquatable(from: filter))
        XCTAssertEqual(result, [3])
    }

//    func testOrMulti() {
//        let _filter: EquatableFilter<Int> = .equalTo(1)
//        let filter = EquatableFilter<Int>.orMulti([_filter])
//        let result = all.filter(Closure.buildCompound(from: filter))
//        XCTAssertEqual(result, [1, 4, 5])
//    }
}
