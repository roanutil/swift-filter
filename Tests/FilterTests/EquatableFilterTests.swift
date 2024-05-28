// EquatableFilterTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import XCTest

final class EquatableFilterTests: XCTestCase {
    func testMap() throws {
        let filter = EquatableFilter.equalTo(1)
        let mappedFilter = EquatableFilter.equalTo("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }
}
