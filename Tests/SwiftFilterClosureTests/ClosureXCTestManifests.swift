// ClosureXCTestManifests.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(ComparableFilterClosureTests.allTests),
            testCase(EquatableFilterClosureTests.allTests),
        ]
    }
#endif
