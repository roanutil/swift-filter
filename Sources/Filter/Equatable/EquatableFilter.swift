// EquatableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// A type that models basic ways of equating values.
///
/// When using indirect cases for compound statements it is best to place more simple operations
/// towards the outside and nest more complicated operations inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
public enum EquatableFilter<T: Equatable>: Equatable {
    case equalTo(T)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    @inlinable
    public func values() -> [T] {
        switch self {
        case let .and(lhs, rhs), let .or(lhs, rhs):
            lhs.values() + rhs.values()
        case let .andMulti(filters), let .orMulti(filters):
            filters.flatMap { $0.values() }
        case let .equalTo(value):
            [value]
        case let .not(filter):
            filter.values()
        }
    }

    /// A wrapper for EquatableFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(EquatableFilter<T>)
        case notNil(EquatableFilter<T>?)
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

        /// Returns the wrapped EquatableFilter from `self`.
        @inlinable
        public var unwrapped: EquatableFilter<T>? {
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

extension EquatableFilter: Hashable where T: Hashable {}

extension EquatableFilter.Optional: Hashable where T: Hashable {}

extension EquatableFilter: Sendable where T: Sendable {}

extension EquatableFilter.Optional: Sendable where T: Sendable {}
