// OptionalFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

//// Optional+Filter.swift
//// Filter
////
////
//// MIT License
////
//// Copyright © 2024 Andrew Roan
//
// import Foundation
//
// public enum OptionalFilter<T>: CompoundFilterable {
//    case orNil(T)
//    case notNil(T?)
//    case isNil
//
//    /// Returns the wrapped Filter from `self`.
//    @inlinable
//    public var unwrapped: T? {
//        switch self {
//        case let .orNil(unwrapped):
//            return unwrapped
//        case let .notNil(unwrapped):
//            return unwrapped
//        case .isNil:
//            return nil
//        }
//    }
// }
//
// extension OptionalFilter: Equatable where T: Equatable {}
//
// extension OptionalFilter: Hashable where T: Hashable {}
//
// extension OptionalFilter: Sendable where T: Sendable {}
//
// extension OptionalFilter: Comparable where T: Comparable {
//    @inlinable
//    public static func < (lhs: OptionalFilter<T>, rhs: OptionalFilter<T>) -> Bool {
//        switch (lhs.unwrapped, rhs.unwrapped) {
//        case (.none, .none):
//            false
//        case (.some, .none):
//            false
//        case (.none, .some):
//            true
//        case let (.some(lhsValue), .some(rhsValue)):
//            lhsValue < rhsValue
//        }
//    }
// }
