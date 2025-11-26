// ComparableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// A type that models basic ways of comparing values.
///
/// When using indirect cases for compound comparisons it is best to place more simple comparisons
/// towards the outside and nest more complicated comparisons inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
public enum ComparableFilter<T: Comparable>: Equatable {
    case lessThan(T)
    case lessThanOrEqualTo(T)
    case greaterThan(T)
    case greaterThanOrEqualTo(T)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)
    case equatable(EquatableFilter<T>)

    @inlinable
    public func values() -> [T] {
        switch self {
        case let .and(lhs, rhs), let .or(lhs, rhs):
            lhs.values() + rhs.values()
        case let .andMulti(filters), let .orMulti(filters):
            filters.flatMap { $0.values() }
        case let .equatable(filter):
            filter.values()
        case let .lessThan(value),
             let .lessThanOrEqualTo(value),
             let .greaterThan(value),
             let .greaterThanOrEqualTo(value):
            [value]
        case let .not(filter):
            filter.values()
        }
    }

    /// A wrapper for ComparableFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(ComparableFilter<T>)
        case notNil(ComparableFilter<T>?)
        case isNil

        @inlinable
        public func values() -> [T] {
            switch self {
            case let .orNil(filter):
                filter.values()
            case let .notNil(filter):
                filter?.values() ?? []
            case .isNil:
                []
            }
        }

        /// Returns the wrapped ComparableFilter from `self`.
        @inlinable
        public var unwrapped: ComparableFilter<T>? {
            switch self {
            case let .orNil(unwrapped):
                unwrapped
            case let .notNil(unwrapped):
                unwrapped
            case .isNil:
                nil
            }
        }
    }
}

extension ComparableFilter: Hashable where T: Hashable {}

extension ComparableFilter.Optional: Hashable where T: Hashable {}

extension ComparableFilter: Sendable where T: Sendable {}

extension ComparableFilter.Optional: Sendable where T: Sendable {}
