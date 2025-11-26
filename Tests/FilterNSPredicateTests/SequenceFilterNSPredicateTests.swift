// SequenceFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

class SequenceFilterNSPredicateTests: XCTestCase {
    let all: [[Int]] = [
        [1],
        [1, 2],
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]
    let allOptional: [[Int]?] = [
        [1],
        nil,
        [1, 2, 3],
        [1, 2, 3, 4],
        [1, 2, 3, 4, 5],
    ]

    // MARK: Sequence

    func testContains() {
        let filter = SequenceFilter<[Int]>.contains(5)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [[1, 2, 3, 4, 5]])
    }

    // MARK: Optional Wrapper

    func testOptionalOrNil() {
        let filter = SequenceFilter<[Int]>.Optional.orNil(.contains(1))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                nil,
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOptionalNotNil() {
        let filter = SequenceFilter<[Int]>.Optional.notNil(.contains(1))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOptionalNotNilWhenNil() {
        let filter = SequenceFilter<[Int]>.Optional.notNil(nil)
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOptionalIsNil() {
        let filter = SequenceFilter<[Int]>.Optional.isNil
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil])
    }

    // MARK: Compound

    func testAnd() {
        let filter = SequenceFilter<[Int]>.and(
            .contains(1),
            .contains(5)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [[1, 2, 3, 4, 5]])
    }

    func testOptionalAnd() {
        let filter = SequenceFilter<[Int]>.Optional.orNil(.and(
            .contains(1),
            .contains(5)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                nil,
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOr() {
        let filter = SequenceFilter<[Int]>.or(
            .contains(1),
            .contains(5)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOptionalOr() {
        let filter = SequenceFilter<[Int]>.Optional.orNil(.or(
            .contains(1),
            .contains(5)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                nil,
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testAndMulti() {
        let filter = SequenceFilter<[Int]>.andMulti([
            .contains(1),
            .contains(5),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [[1, 2, 3, 4, 5]])
    }

    func testOptionalAndMulti() {
        let filter = SequenceFilter<[Int]>.Optional.orNil(.andMulti([
            .contains(1),
            .contains(5),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                nil,
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOrMulti() {
        let filter = SequenceFilter<[Int]>.orMulti([
            .contains(1),
            .contains(5),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                [1, 2],
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }

    func testOptionalOrMulti() {
        let filter = SequenceFilter<[Int]>.Optional.orNil(.orMulti([
            .contains(1),
            .contains(5),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(
            result,
            [
                [1],
                nil,
                [1, 2, 3],
                [1, 2, 3, 4],
                [1, 2, 3, 4, 5],
            ]
        )
    }
}
