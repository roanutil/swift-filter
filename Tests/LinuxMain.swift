// LinuxMain.swift
// Filter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import XCTest

import FilterTests

var tests = [XCTestCaseEntry]()
tests += FilterClosureTests.allTests()
tests += FilterNSPredicateTests.allTests()
XCTMain(tests)
