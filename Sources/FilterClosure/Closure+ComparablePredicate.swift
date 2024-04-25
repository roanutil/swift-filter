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
    public static func build(
        from filter: ComparableFilter<Value>,
        extract: @escaping (Root) -> Value
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .lessThan(bound):
            return { extract($0) < bound }
        case let .lessThanOrEqualTo(bound):
            return { extract($0) <= bound }
        case let .greaterThan(bound):
            return { extract($0) > bound }
        case let .greaterThanOrEqualTo(bound):
            return { extract($0) >= bound }
        case let .equatable(equatable):
            return Self.build(from: equatable, extract: extract)
        }
    }
}
