// NSPredicate+AnySequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnySequencePredicate {
    /// Creates a NSPredicate from a SequenceFilter
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Value>(
        from filter: SequenceFilter<Value>,
        accessor: NSExpression
    ) -> NSPredicate where Value: Sequence {
        accessor.comparisonPredicate(
            NSExpression(forConstantValue: [filter.contains]),
            modifier: .any,
            type: .in
        )
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: SequenceFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath))
    }

    @inlinable
    public static func build<Value>(
        from filter: SequenceFilter<Value>
    ) -> NSPredicate {
        build(from: filter, on: \Value.self)
    }
}
