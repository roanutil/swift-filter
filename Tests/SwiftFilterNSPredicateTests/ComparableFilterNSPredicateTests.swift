// ComparableFilterNSPredicateTests.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import SwiftFilter
import SwiftFilterNSPredicate
import XCTest

class ComparableFilterNSPredicateTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Comparable

    func testLessThan() {
        let filter = ComparableFilter<Int>.lessThan(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 2])
    }

    func testOptionalLessThan() {
        let filter = ComparableFilter<Int>.Optional.notNil(.lessThan(3))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1])
    }

    func testGreaterThan() {
        let filter = ComparableFilter<Int>.greaterThan(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [4, 5])
    }

    func testOptionalGreaterThan() {
        let filter = ComparableFilter<Int>.Optional.notNil(.greaterThan(3))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [4, 5])
    }

    func testLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.lessThanOrEqualTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 2, 3])
    }

    func testOptionalLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.Optional.notNil(.lessThanOrEqualTo(3))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 3])
    }

    func testGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.greaterThanOrEqualTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3, 4, 5])
    }

    func testOptionalGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.Optional.notNil(.greaterThanOrEqualTo(3))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3, 4, 5])
    }

    func testNotLessThan() {
        let filter = ComparableFilter<Int>.not(.lessThan(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3, 4, 5])
    }

    func testOptionalNotLessThan() {
        let filter = ComparableFilter<Int>.Optional.notNil(.not(.lessThan(3)))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3, 4, 5])
    }

    func testNotGreaterThan() {
        let filter = ComparableFilter<Int>.not(.greaterThan(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 2, 3])
    }

    func testOptionalNotGreaterThan() {
        let filter = ComparableFilter<Int>.Optional.notNil(.not(.greaterThan(3)))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 3])
    }

    func testNotLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.not(.lessThanOrEqualTo(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [4, 5])
    }

    func testOptionalNotLessThanOrEqualTo() {
        let filter = ComparableFilter<Int>.Optional.notNil(.not(.lessThanOrEqualTo(3)))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [4, 5])
    }

    func testNotGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.not(.greaterThanOrEqualTo(3))
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 2])
    }

    func testOptionalNotGreaterThanOrEqualTo() {
        let filter = ComparableFilter<Int>.Optional.notNil(.not(.greaterThanOrEqualTo(3)))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1])
    }

    func testNone() {
        let filter = ComparableFilter<Int>.none
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 2, 3, 4, 5])
    }

    // MARK: Optional Wrapper

    func testOptionalOrNil() {
        let filter = ComparableFilter<Int>.Optional.orNil(.none)
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, nil, 3, 4, 5])
    }

    func testOptionalNotNil() {
        let filter = ComparableFilter<Int>.Optional.notNil(.none)
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 3, 4, 5])
    }

    func testOptionalIsNil() {
        let filter = ComparableFilter<Int>.Optional.isNil
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [nil])
    }

    // MARK: Compound

    func testAnd() {
        let filter = ComparableFilter<Int>.and(
            .lessThan(4),
            .greaterThanOrEqualTo(2)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [2, 3])
    }

    func testOptionalAnd() {
        let filter = ComparableFilter<Int>.Optional.notNil(.and(
            .lessThan(4),
            .greaterThanOrEqualTo(2)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3])
    }

    func testOr() {
        let filter = ComparableFilter<Int>.or(
            .lessThan(2),
            .greaterThanOrEqualTo(4)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 4, 5])
    }

    func testOptionalOr() {
        let filter = ComparableFilter<Int>.Optional.notNil(.or(
            .lessThan(2),
            .greaterThanOrEqualTo(4)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 4, 5])
    }

    func testAndMulti() {
        let filter = ComparableFilter<Int>.andMulti([
            .lessThan(4),
            .greaterThanOrEqualTo(2),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [2, 3])
    }

    func testOptionalAndMulti() {
        let filter = ComparableFilter<Int>.Optional.notNil(.andMulti([
            .lessThan(4),
            .greaterThanOrEqualTo(2),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [3])
    }

    func testOrMulti() {
        let filter = ComparableFilter<Int>.orMulti([
            .lessThan(2),
            .greaterThanOrEqualTo(4),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 4, 5])
    }

    func testOptionalOrMulti() {
        let filter = ComparableFilter<Int>.Optional.notNil(.orMulti([
            .lessThan(2),
            .greaterThanOrEqualTo(4),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        assert(result == [1, 4, 5])
    }

    static var allTests = [
        ("testLessThan", testLessThan),
        ("testOptionalLessThan", testOptionalLessThan),
        ("testGreaterThan", testGreaterThan),
        ("testOptionalGreaterThan", testOptionalGreaterThan),
        ("testLessThanOrEqualTo", testLessThanOrEqualTo),
        ("testOptionalLessThanOrEqualTo", testOptionalLessThanOrEqualTo),
        ("testGreaterThanOrEqualTo", testGreaterThanOrEqualTo),
        ("testOptionalGreaterThanOrEqualTo", testOptionalGreaterThanOrEqualTo),
        ("testNotLessThan", testNotLessThan),
        ("testOptionalNotLessThan", testOptionalNotLessThan),
        ("testNotGreaterThan", testNotGreaterThan),
        ("testOptionalNotGreaterThan", testOptionalNotGreaterThan),
        ("testNotLessThanOrEqualTo", testNotLessThanOrEqualTo),
        ("testOptionalNotLessThanOrEqualTo", testOptionalNotLessThanOrEqualTo),
        ("testNotGreaterThanOrEqualTo", testNotGreaterThanOrEqualTo),
        ("testOptionalNotGreaterThanOrEqualTo", testOptionalNotGreaterThanOrEqualTo),
        ("testOptionalOrNil", testOptionalOrNil),
        ("testOptionalNotNil", testOptionalNotNil),
        ("testOptionalIsNil", testOptionalIsNil),
        ("testAnd", testAnd),
        ("testOptionalAnd", testOptionalAnd),
        ("testOr", testOr),
        ("testOptionalOr", testOptionalOr),
        ("testAndMulti", testAndMulti),
        ("testOptionalAndMulti", testOptionalAndMulti),
        ("testOrMulti", testOrMulti),
        ("testOptionalOrMulti", testOptionalOrMulti),
    ]
}
