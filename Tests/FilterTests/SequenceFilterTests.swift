// SequenceFilterTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import XCTest

final class SequenceFilterTests: XCTestCase {
    func testMap() throws {
        let filter = SequenceFilter<[Int]>.contains(1)
        let mappedFilter = SequenceFilter<[String]>.contains("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }
}
