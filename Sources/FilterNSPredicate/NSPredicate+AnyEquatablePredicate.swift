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
    public static func build<Value>(
        from filter: EquatableFilter<Value>,
        accessor: NSExpression
    ) -> NSPredicate where Value: Equatable {
        accessor.equalTo(NSExpression(forConstantValue: filter.equalTo))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Equatable {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath))
    }

    @inlinable
    public static func build<Value>(
        from filter: EquatableFilter<Value>
    ) -> NSPredicate where Value: Equatable {
        build(from: filter, on: \Value.self)
    }
}
