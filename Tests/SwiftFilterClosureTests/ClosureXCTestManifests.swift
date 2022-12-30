// ClosureXCTestManifests.swift
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
            testCase(ComparableFilterClosureTests.allTests),
            testCase(EquatableFilterClosureTests.allTests),
        ]
    }
#endif
