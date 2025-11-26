// Closure+OptionalCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Filter
import Foundation

extension Closure: OptionalCollectionPredicate where Value: Collection, Value: Equatable, Value.Element: Equatable {
    /// Creates a closure `(Self) -> Bool` from a CollectionFilter
    ///
    /// - Parameter filter: An instance of CollectionFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(from filter: CollectionFilter<Value>.Optional,
                             on keyPath: KeyPath<Root, Value?>) -> (@Sendable (Root) -> Bool)
    {
        switch filter {
        case let .orNil(subFilter):
            { value in
                guard let value = value[keyPath: keyPath] else { return true }
                return Closure<Value, Value>.build(from: subFilter)(value)
            }
        case let .notNil(subFilter):
            { value in
                guard let value = value[keyPath: keyPath] else { return false }
                if let subFilter {
                    return Closure<Value, Value>.build(from: subFilter)(value)
                }
                return true
            }
        case .isNil:
            { $0[keyPath: keyPath] == nil }
        }
    }
}
