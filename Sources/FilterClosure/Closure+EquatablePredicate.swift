// Closure+EquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: EquatablePredicate where Value: Equatable {
    /// Creates a closure `(Self) -> Bool` from a EquatableFilter
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> (@Sendable (Root) -> Bool) {
        { $0[keyPath: keyPath] == filter.equalTo }
    }
}
