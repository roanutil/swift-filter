import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ComparableFilterTests.allTests),
        testCase(EquatableFilterTests.allTests)
    ]
}
#endif
