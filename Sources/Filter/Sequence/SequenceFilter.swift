// SequenceFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

public enum SequenceFilter<S>: Equatable where S: Sequence, S: Equatable, S.Element: Equatable {
    case contains(S.Element)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    /// A wrapper for SequenceFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(SequenceFilter<S>)
        case notNil(SequenceFilter<S>?)
        case isNil

        /// Returns the wrapped SequenceFilter from `self`.
        @inlinable
        public var unwrapped: SequenceFilter<S>? {
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

extension SequenceFilter: Hashable where S: Hashable, S.Element: Hashable {}

extension SequenceFilter.Optional: Hashable where S: Hashable, S.Element: Hashable {}

extension SequenceFilter: Sendable where S: Sendable, S.Element: Sendable {}

extension SequenceFilter.Optional: Sendable where S: Sendable, S.Element: Sendable {}
