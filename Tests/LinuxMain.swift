// LinuxMain.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import XCTest

import SwiftFilterTests

var tests = [XCTestCaseEntry]()
tests += SwiftFilterClosureTests.allTests()
tests += SwiftFilterNSPredicateTests.allTests()
XCTMain(tests)
