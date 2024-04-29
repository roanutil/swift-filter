// CollectionFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

public enum CollectionFilter<C>: Equatable where C: Collection, C: Equatable, C.Element: Equatable {
    case isIn(C)
    case sequence(SequenceFilter<C>)
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    /// A wrapper for CollectionFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(CollectionFilter<C>)
        case notNil(CollectionFilter<C>?)
        case isNil

        /// Returns the wrapped CollectionFilter from `self`.
        @inlinable
        public var unwrapped: CollectionFilter<C>? {
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
        case equatable(EquatableFilter<C.Element>)
    }
}

extension CollectionFilter: Hashable where C: Hashable, C.Element: Hashable {}

extension CollectionFilter.Optional: Hashable where C: Hashable, C.Element: Hashable {}

extension CollectionFilter: Sendable where C: Sendable, C.Element: Sendable {}

extension CollectionFilter.Optional: Sendable where C: Sendable, C.Element: Sendable {}
