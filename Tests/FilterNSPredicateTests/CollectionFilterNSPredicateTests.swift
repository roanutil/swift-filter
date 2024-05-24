// CollectionFilterNSPredicateTests.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import FilterNSPredicate
import XCTest

// class CollectionFilterNSPredicateTests: XCTestCase {
//    let all: [[Int]] = [
//        [1],
//        [1, 2],
//        [1, 2, 3],
//        [1, 2, 3, 4],
//        [1, 2, 3, 4, 5],
//    ]
//    let allOptional: [[Int]?] = [
//        [1],
//        nil,
//        [1, 2, 3],
//        [1, 2, 3, 4],
//        [1, 2, 3, 4, 5],
//    ]
//
//    // MARK: Collection
//
//    func testContains() {
//        let filter = CollectionFilter<[Int]>.isIn([1, 2, 3])
//        let result = all.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2],
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    // MARK: Optional Wrapper
//
//    func testOptionalOrNil() {
//        let filter = CollectionFilter<[Int]>.Optional.orNil(.isIn([1, 2, 3]))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                nil,
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    func testOptionalNotNil() {
//        let filter = CollectionFilter<[Int]>.Optional.notNil(.isIn([1, 2, 3]))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    func testOptionalNotNilWhenNil() {
//        let filter = CollectionFilter<[Int]>.Optional.notNil(nil)
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2, 3],
//                [1, 2, 3, 4],
//                [1, 2, 3, 4, 5],
//            ]
//        )
//    }
//
//    func testOptionalIsNil() {
//        let filter = CollectionFilter<[Int]>.Optional.isNil
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(result, [nil])
//    }
//
//    // MARK: Compound
//
//    func testAnd() {
//        let filter = CollectionFilter<[Int]>.and(
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4])
//        )
//        let result = all.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2],
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    func testOptionalAnd() {
//        let filter = CollectionFilter<[Int]>.Optional.orNil(.and(
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4])
//        ))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                nil,
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    func testOr() {
//        let filter = CollectionFilter<[Int]>.or(
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4])
//        )
//        let result = all.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2],
//                [1, 2, 3],
//                [1, 2, 3, 4],
//            ]
//        )
//    }
//
//    func testOptionalOr() {
//        let filter = CollectionFilter<[Int]>.Optional.orNil(.or(
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4])
//        ))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                nil,
//                [1, 2, 3],
//                [1, 2, 3, 4],
//            ]
//        )
//    }
//
//    func testAndMulti() {
//        let filter = CollectionFilter<[Int]>.andMulti([
//            .isIn([1]),
//            .isIn([1, 2]),
//        ])
//        let result = all.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(result, [[1]])
//    }
//
//    func testOptionalAndMulti() {
//        let filter = CollectionFilter<[Int]>.Optional.orNil(.andMulti([
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4]),
//        ]))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                nil,
//                [1, 2, 3],
//            ]
//        )
//    }
//
//    func testOrMulti() {
//        let filter = CollectionFilter<[Int]>.orMulti([
//            .isIn([1]),
//            .isIn([1, 2]),
//        ])
//        let result = all.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                [1, 2],
//            ]
//        )
//    }
//
//    func testOptionalOrMulti() {
//        let filter = CollectionFilter<[Int]>.Optional.orNil(.orMulti([
//            .isIn([1, 2, 3]),
//            .isIn([1, 2, 3, 4]),
//        ]))
//        let result = allOptional.filter(NSPredicate.build(from: filter).closure)
//        XCTAssertEqual(
//            result,
//            [
//                [1],
//                nil,
//                [1, 2, 3],
//                [1, 2, 3, 4],
//            ]
//        )
//    }
// }
