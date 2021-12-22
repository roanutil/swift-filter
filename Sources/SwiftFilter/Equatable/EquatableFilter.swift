// EquatableFilter.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import Foundation

/// A type that models basic ways of equating values.
///
/// When using indirect cases for compound statements it is best to place more simple operations
/// towards the outside and nest more complicated operations inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure the structure
/// is maintained so that the outer most is evaluated first.
public enum EquatableFilter<T: Equatable>: Equatable {
    case equalTo(T)
    case none // Always evaluates to true
    indirect case or(Self, Self)
    indirect case orMulti([Self])
    indirect case and(Self, Self)
    indirect case andMulti([Self])
    indirect case not(Self)

    /// A wrapper for EquatableFilter when comparing an optional type.
    public enum Optional: Equatable {
        case orNil(EquatableFilter<T>)
        case notNil(EquatableFilter<T>)
        case isNil

        /// Returns the wrapped EquatableFilter from `self`.
        public var unwrapped: EquatableFilter<T> {
            switch self {
            case let .orNil(unwrapped):
                return unwrapped
            case let .notNil(unwrapped):
                return unwrapped
            case .isNil:
                return .none
            }
        }
    }
}
