// CompoundComparableFilterNSPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

final class CompoundComparableFilterNSPredicateTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    func testAnd() {
        let filter = ComparableFilter<Int>.and(
            .lessThan(4),
            .greaterThan(2)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3])
    }

    func testAndMulti() {
        let filter = ComparableFilter<Int>.andMulti([
            .lessThanOrEqualTo(5),
            .greaterThanOrEqualTo(1),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }

    func testNot() {
        let filter = ComparableFilter<Int>.not(.greaterThan(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 2, 3])
    }

    func testOr() {
        let filter = ComparableFilter<Int>.or(
            .equatable(.equalTo(1)),
            .equatable(.equalTo(4))
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 4])
    }

    func testOrMulti() {
        let filter = ComparableFilter<Int>.orMulti([
            .lessThanOrEqualTo(2),
            .equatable(.equalTo(3)),
            .greaterThanOrEqualTo(4),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }
}
