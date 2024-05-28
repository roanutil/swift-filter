// ComparableFilterTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import XCTest

final class ComparableFilterTests: XCTestCase {
    func testEquatableMap() throws {
        let filter = ComparableFilter.equatable(.equalTo(1))
        let mappedFilter = ComparableFilter.equatable(.equalTo("1"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testEquatableValue() throws {
        let filter = ComparableFilter.equatable(.equalTo(1))
        let expectedValue = 1
        XCTAssertEqual(filter.value(), expectedValue)
    }

    func testGreaterThanMap() throws {
        let filter = ComparableFilter.greaterThan(1)
        let mappedFilter = ComparableFilter.greaterThan("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testGreaterThanValue() throws {
        let filter = ComparableFilter.greaterThan(1)
        let expectedValue = 1
        XCTAssertEqual(filter.value(), expectedValue)
    }

    func testGreaterThanOrEqualToMap() throws {
        let filter = ComparableFilter.greaterThanOrEqualTo(1)
        let mappedFilter = ComparableFilter.greaterThanOrEqualTo("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testGreaterThanOrEqualValue() throws {
        let filter = ComparableFilter.greaterThanOrEqualTo(1)
        let expectedValue = 1
        XCTAssertEqual(filter.value(), expectedValue)
    }

    func testLessThanMap() throws {
        let filter = ComparableFilter.lessThan(1)
        let mappedFilter = ComparableFilter.lessThan("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testLessThanValue() throws {
        let filter = ComparableFilter.lessThan(1)
        let expectedValue = 1
        XCTAssertEqual(filter.value(), expectedValue)
    }

    func testLessThanOrEqualToMap() throws {
        let filter = ComparableFilter.lessThanOrEqualTo(1)
        let mappedFilter = ComparableFilter.lessThanOrEqualTo("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testLessThanOrEqualValue() throws {
        let filter = ComparableFilter.lessThanOrEqualTo(1)
        let expectedValue = 1
        XCTAssertEqual(filter.value(), expectedValue)
    }
}
