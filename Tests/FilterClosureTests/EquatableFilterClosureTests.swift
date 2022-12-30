// EquatableFilterClosureTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import Filter
import FilterClosure
import XCTest

class EquatableFilterClosureTests: XCTestCase {
    let all: [Int] = [1, 2, 3, 4, 5]
    let allOptional: [Int?] = [1, nil, 3, 4, 5]

    // MARK: Equatable

    func testEqualTo() {
        let filter = EquatableFilter.equalTo(3)
        let result = all.filter(Closure.build(from: filter))
        assert(result == [3])
    }

    func testOptionalEqualTo() {
        let filter = EquatableFilter<Int?>.equalTo(3)
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [3])
    }

    func testNone() {
        let filter = EquatableFilter<Int>.none
        let result = all.filter(Closure.build(from: filter))
        assert(result == [1, 2, 3, 4, 5])
    }

    // MARK: Optional Wrapper

    func testOptionalOrNil() {
        let filter = EquatableFilter<Int>.Optional.orNil(.none)
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [1, nil, 3, 4, 5])
    }

    func testOptionalNotNil() {
        let filter = EquatableFilter<Int>.Optional.notNil(.none)
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [1, 3, 4, 5])
    }

    func testOptionalIsNil() {
        let filter = EquatableFilter<Int>.Optional.isNil
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [nil])
    }

    // MARK: Compound

    func testAnd() {
        let filter = EquatableFilter<Int>.and(
            .equalTo(2),
            .equalTo(3)
        )
        let result = all.filter(Closure.build(from: filter))
        assert(result == [])
    }

    func testOptionalAnd() {
        let filter = EquatableFilter<Int>.Optional.orNil(.and(
            .equalTo(2),
            .equalTo(3)
        ))
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [nil])
    }

    func testOr() {
        let filter = EquatableFilter<Int>.or(
            .equalTo(2),
            .equalTo(3)
        )
        let result = all.filter(Closure.build(from: filter))
        assert(result == [2, 3])
    }

    func testOptionalOr() {
        let filter = EquatableFilter<Int>.Optional.orNil(.or(
            .equalTo(2),
            .equalTo(3)
        ))
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [nil, 3])
    }

    func testAndMulti() {
        let filter = EquatableFilter<Int>.andMulti([
            .equalTo(2),
            .equalTo(3),
        ])
        let result = all.filter(Closure.build(from: filter))
        assert(result == [])
    }

    func testOptionalAndMulti() {
        let filter = EquatableFilter<Int>.Optional.orNil(.andMulti([
            .equalTo(2),
            .equalTo(3),
        ]))
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [nil])
    }

    func testOrMulti() {
        let filter = EquatableFilter<Int>.orMulti([
            .equalTo(2),
            .equalTo(3),
        ])
        let result = all.filter(Closure.build(from: filter))
        assert(result == [2, 3])
    }

    func testOptionalOrMulti() {
        let filter = EquatableFilter<Int>.Optional.orNil(.orMulti([
            .equalTo(2),
            .equalTo(3),
        ]))
        let result = allOptional.filter(Closure.build(from: filter))
        assert(result == [nil, 3])
    }

    static var allTests = [
        ("testEqualTo", testEqualTo),
        ("testOptionalEqualTo", testOptionalEqualTo),
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
