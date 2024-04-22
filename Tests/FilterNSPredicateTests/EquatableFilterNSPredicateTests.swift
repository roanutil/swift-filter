// EquatableFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterClosure
import XCTest

class EquatableFilterNSPredicateTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter.equalTo(3)
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3])
    }

    func testOptionalEqualTo() {
        let filter = EquatableFilter<Int?>.equalTo(3)
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [3])
    }

    // MARK: Optional Wrapper

    func testOptionalOrNil() {
        let filter = EquatableFilter<Int>.Optional.orNil(.orMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, nil, 4, 5])
    }

    func testOptionalNotNil() {
        let filter = EquatableFilter<Int>.Optional.notNil(nil)
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 3, 4, 5])
    }
    
    func testOptionalNotNilWithSubFilter() {
        let filter = EquatableFilter<Int>.Optional.notNil(.orMulti([
            .equalTo(1),
            .equalTo(4),
            .equalTo(5),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [1, 4, 5])
    }

    func testOptionalIsNil() {
        let filter = EquatableFilter<Int>.Optional.isNil
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil])
    }

    // MARK: Compound

    func testAnd() {
        let filter = EquatableFilter<Int>.and(
            .equalTo(2),
            .equalTo(3)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [])
    }

    func testOptionalAnd() {
        let filter = EquatableFilter<Int>.Optional.orNil(.and(
            .equalTo(2),
            .equalTo(3)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil])
    }

    func testOr() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(2),
            .equalTo(3)
        )
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [2, 3])
    }

    func testOptionalOr() {
        let filter = EquatableFilter<Int>.Optional.orNil(.or(
            .equalTo(2),
            .equalTo(3)
        ))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil, 3])
    }

    func testAndMulti() {
        let filter = EquatableFilter<Int>.andMulti([
            .equalTo(2),
            .equalTo(3),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [])
    }

    func testOptionalAndMulti() {
        let filter = EquatableFilter<Int>.Optional.orNil(.andMulti([
            .equalTo(2),
            .equalTo(3),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil])
    }

    func testOrMulti() {
        let filter = EquatableFilter<Int>.orMulti([
            .equalTo(2),
            .equalTo(3),
        ])
        let result = all.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [2, 3])
    }

    func testOptionalOrMulti() {
        let filter = EquatableFilter<Int>.Optional.orNil(.orMulti([
            .equalTo(2),
            .equalTo(3),
        ]))
        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
        XCTAssertEqual(result, [nil, 3])
    }
}
