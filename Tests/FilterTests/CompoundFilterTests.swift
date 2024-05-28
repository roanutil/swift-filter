// CompoundFilterTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import XCTest

final class CompoundFilterTests: XCTestCase {
    func testAndMap() throws {
        let filter = CompoundFilter.and(1, 2)
        let mappedFilter = CompoundFilter.and("1", "2")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testAndValues() throws {
        let filter = CompoundFilter.and(1, 2)
        let expectedValues = [1, 2]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testAndNestedMap() throws {
        let filter = CompoundFilter.andNested(.and(1, 2), .and(3, 4))
        let mappedFilter = CompoundFilter.andNested(.and("1", "2"), .and("3", "4"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testAndNestedValues() throws {
        let filter = CompoundFilter.andNested(.and(1, 2), .and(3, 4))
        let expectedValues = [1, 2, 3, 4]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testAndMultiMap() throws {
        let filter = CompoundFilter.andMulti([1, 2])
        let mappedFilter = CompoundFilter.andMulti(["1", "2"])
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testAndMultiValues() throws {
        let filter = CompoundFilter.andMulti([1, 2])
        let expectedValues = [1, 2]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testAndMultiNestedMap() throws {
        let filter = CompoundFilter.andMultiNested([.and(1, 2), .and(3, 4)])
        let mappedFilter = CompoundFilter.andMultiNested([.and("1", "2"), .and("3", "4")])
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testAndMultiNestedValues() throws {
        let filter = CompoundFilter.andMultiNested([.and(1, 2), .and(3, 4)])
        let expectedValues = [1, 2, 3, 4]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testNotMap() throws {
        let filter = CompoundFilter.not(1)
        let mappedFilter = CompoundFilter.not("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testNotValues() throws {
        let filter = CompoundFilter.notNested(.not(1))
        let expectedValues = [1]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testNotNestedMap() throws {
        let filter = CompoundFilter.notNested(.not(1))
        let mappedFilter = CompoundFilter.notNested(.not("1"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testNotNestedValues() throws {
        let filter = CompoundFilter.not(1)
        let expectedValues = [1]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testOrMap() throws {
        let filter = CompoundFilter.or(1, 2)
        let mappedFilter = CompoundFilter.or("1", "2")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testOrValues() throws {
        let filter = CompoundFilter.or(1, 2)
        let expectedValues = [1, 2]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testOrNestedMap() throws {
        let filter = CompoundFilter.orNested(.or(1, 2), .or(3, 4))
        let mappedFilter = CompoundFilter.orNested(.or("1", "2"), .or("3", "4"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testOrNestedValues() throws {
        let filter = CompoundFilter.orNested(.or(1, 2), .or(3, 4))
        let expectedValues = [1, 2, 3, 4]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testOrMultiMap() throws {
        let filter = CompoundFilter.orMulti([1, 2])
        let mappedFilter = CompoundFilter.orMulti(["1", "2"])
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testOrMultiValues() throws {
        let filter = CompoundFilter.orMulti([1, 2])
        let expectedValues = [1, 2]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testOrMultiNestedMap() throws {
        let filter = CompoundFilter.orMultiNested([.or(1, 2), .or(3, 4)])
        let mappedFilter = CompoundFilter.orMultiNested([.or("1", "2"), .or("3", "4")])
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testOrMultiNestedValues() throws {
        let filter = CompoundFilter.orMultiNested([.or(1, 2), .or(3, 4)])
        let expectedValues = [1, 2, 3, 4]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testPassthroughMap() throws {
        let filter = CompoundFilter.passthrough(1)
        let mappedFilter = CompoundFilter.passthrough("1")
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testPassthroughValues() throws {
        let filter = CompoundFilter.passthrough(1)
        let expectedValues = [1]
        XCTAssertEqual(filter.values(), expectedValues)
    }

    func testComparableMap() throws {
        let filter = ComparableFilter.greaterThan(1)
            .and(.lessThan(0))
        let mappedFilter = ComparableFilter.greaterThan("1")
            .and(.lessThan("0"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testEquatableMap() throws {
        let filter = EquatableFilter.equalTo(1)
            .or(.equalTo(2))
        let mappedFilter = EquatableFilter.equalTo("1")
            .or(.equalTo("2"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }

    func testSequenceMap() throws {
        let filter = SequenceFilter<[Int]>.contains(1)
            .or(.contains(2))
        let mappedFilter = SequenceFilter<[String]>.contains("1")
            .or(.contains("2"))
        XCTAssertEqual(filter.map(\.description), mappedFilter)
    }
}
