// ComparableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// A type that models basic ways of comparing values.
///
/// When using indirect cases for compound comparisons it is best to place more simple comparisons
/// towards the outside and nest more complicated comparisons inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
public enum ComparableFilter<T: Comparable>: Equatable, CompoundFilterable {
    case lessThan(T)
    case lessThanOrEqualTo(T)
    case greaterThan(T)
    case greaterThanOrEqualTo(T)
    case equatable(EquatableFilter<T>)

    /// A wrapper for ComparableFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(ComparableFilter<T>)
        case notNil(ComparableFilter<T>?)
        case isNil

        /// Returns the wrapped ComparableFilter from `self`.
        @inlinable
        public var unwrapped: ComparableFilter<T>? {
            switch self {
            case let .orNil(unwrapped):
                return unwrapped
            case let .notNil(unwrapped):
                return unwrapped
            case .isNil:
                return nil
            }
        }
    }
}

extension ComparableFilter: Hashable where T: Hashable {}

extension ComparableFilter.Optional: Hashable where T: Hashable {}

extension ComparableFilter: Sendable where T: Sendable {}

extension ComparableFilter.Optional: Sendable where T: Sendable {}
