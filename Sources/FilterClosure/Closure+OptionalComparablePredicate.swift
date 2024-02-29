// Closure+OptionalComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: OptionalComparablePredicate where Value: Comparable {
    /// Creates a closure `(Self) -> Bool` from a ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    public static func build(from filter: ComparableFilter<Value>.Optional,
                             on keyPath: KeyPath<Root, Value?>) -> ((Root) -> Bool)
    {
        switch filter {
        case let .orNil(subFilter):
            return { value in
                guard let value = value[keyPath: keyPath] else { return true }
                return Closure<Value, Value>.build(from: subFilter)(value)
            }
        case let .notNil(subFilter):
            return { value in
                guard let value = value[keyPath: keyPath] else { return false }
                return Closure<Value, Value>.build(from: subFilter)(value)
            }
        case .isNil:
            return { $0[keyPath: keyPath] == nil }
        }
    }
}
