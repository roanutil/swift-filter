// CollectionFilterTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import XCTest

final class CollectionFilterTests: XCTestCase {
    func testMap() throws {
        let filter = CollectionFilter<[Int]>.isIn([1, 2])
        let mappedFilter = CollectionFilter<[String]>.isIn(["1", "2"])
        XCTAssertEqual(filter.map({ $0.map(\.description) }, sequence: \.description), mappedFilter)
    }

    func testSequenceMap() throws {
        let filter = CollectionFilter<[Int]>.sequence(.contains(1))
        let mappedFilter = CollectionFilter<[String]>.sequence(.contains("1"))
        XCTAssertEqual(filter.map({ $0.map(\.description) }, sequence: \.description), mappedFilter)
    }
}
