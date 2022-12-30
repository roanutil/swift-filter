// NSPredicateXCTestManifests.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(ComparableFilterNSPredicateTests.allTests),
            testCase(EquatableFilterNSPredicateTests.allTests),
        ]
    }
#endif
