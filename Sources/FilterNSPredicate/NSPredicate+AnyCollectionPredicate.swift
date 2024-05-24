// NSPredicate+AnyCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyCollectionPredicate {
    /// Creates a NSPredicate from a SequenceFilter
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: CollectionFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
        switch filter {
        case let .isIn(values):
            NSExpression(forKeyPath: keyPath).comparisonPredicate(
                NSExpression(forConstantValue: values),
                modifier: .all,
                type: .in
            )
        case let .sequence(sequenceFilter):
            build(from: sequenceFilter, on: keyPath)
        }
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by SequenceFilter.Optional
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: CollectionFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
        switch filter {
        case let .isIn(values):
            NSExpression(forKeyPath: keyPath).comparisonPredicate(
                NSExpression(forConstantValue: values),
                modifier: .all,
                type: .in
            )
        case let .sequence(sequenceFilter):
            build(from: sequenceFilter, on: keyPath)
        }
    }
}
