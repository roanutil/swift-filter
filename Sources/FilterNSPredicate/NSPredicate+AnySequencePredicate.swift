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
    public static func build<Root, Value>(
        from filter: SequenceFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
        NSExpression(forKeyPath: keyPath).comparisonPredicate(
            NSExpression(forConstantValue: [filter.contains]),
            modifier: .any,
            type: .in
        )
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by SequenceFilter.Optional
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: SequenceFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
        NSExpression(forKeyPath: keyPath).comparisonPredicate(
            NSExpression(forConstantValue: [filter.contains]),
            modifier: .any,
            type: .in
        )
    }
}
