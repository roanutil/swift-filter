// NSPredicate+AnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyEquatablePredicate {
    /// Creates a NSPredicate from a EquatableFilter
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Equatable {
        NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: filter.equalTo))
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Equatable {
        NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: filter.equalTo))
    }
}
