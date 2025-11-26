// SequenceFilter.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

public enum SequenceFilter<S>: Equatable where S: Sequence, S: Equatable, S.Element: Equatable {
    case contains(S.Element)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    @inlinable
    public func values() -> [S.Element] {
        switch self {
        case let .and(lhs, rhs), let .or(lhs, rhs):
            lhs.values() + rhs.values()
        case let .andMulti(filters), let .orMulti(filters):
            filters.flatMap { $0.values() }
        case let .contains(value):
            [value]
        case let .not(filter):
            filter.values()
        }
    }

    /// A wrapper for SequenceFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(SequenceFilter<S>)
        case notNil(SequenceFilter<S>?)
        case isNil

        @inlinable
        public func values() -> [S.Element] {
            switch self {
            case let .orNil(filter):
                filter.values()
            case let .notNil(filter):
                filter?.values() ?? []
            case .isNil:
                []
            }
        }

        /// Returns the wrapped SequenceFilter from `self`.
        @inlinable
        public var unwrapped: SequenceFilter<S>? {
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

extension SequenceFilter: Hashable where S: Hashable, S.Element: Hashable {}

extension SequenceFilter.Optional: Hashable where S: Hashable, S.Element: Hashable {}

extension SequenceFilter: Sendable where S: Sendable, S.Element: Sendable {}

extension SequenceFilter.Optional: Sendable where S: Sendable, S.Element: Sendable {}
