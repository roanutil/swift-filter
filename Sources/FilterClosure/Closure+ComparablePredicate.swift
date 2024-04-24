// Closure+ComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: ComparablePredicate where Value: Comparable {
    /// Creates a closure `(Self) -> Bool` from a ComparableFilter
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func buildComparable(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .lessThan(bound):
            return { $0[keyPath: keyPath] < bound }
        case let .lessThanOrEqualTo(bound):
            return { $0[keyPath: keyPath] <= bound }
        case let .greaterThan(bound):
            return { $0[keyPath: keyPath] > bound }
        case let .greaterThanOrEqualTo(bound):
            return { $0[keyPath: keyPath] >= bound }
        case let .equatable(equatable):
            return Self.buildEquatable(from: equatable, on: keyPath)
        }
    }
}
