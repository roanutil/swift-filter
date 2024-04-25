// CollectionFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

public enum CollectionFilter<S>: Equatable where S: Collection, S: Equatable, S.Element: Equatable {
    case isIn(S)
    case sequence(SequenceFilter<S>)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    /// A wrapper for CollectionFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(CollectionFilter<S>)
        case notNil(CollectionFilter<S>?)
        case isNil

        /// Returns the wrapped CollectionFilter from `self`.
        @inlinable
        public var unwrapped: CollectionFilter<S>? {
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

    public enum Element: Equatable {
        case equatable(EquatableFilter<S.Element>)
    }
}

extension CollectionFilter: Hashable where S: Hashable, S.Element: Hashable {}

extension CollectionFilter.Optional: Hashable where S: Hashable, S.Element: Hashable {}

extension CollectionFilter: Sendable where S: Sendable, S.Element: Sendable {}

extension CollectionFilter.Optional: Sendable where S: Sendable, S.Element: Sendable {}
