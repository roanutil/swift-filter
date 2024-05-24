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
    public static func build<Value>(
        from filter: CollectionFilter<Value>,
        accessor: NSExpression
    ) -> NSPredicate where Value: Collection, Value: Equatable, Value.Element: Equatable {
        switch filter {
        case let .isIn(isIn):
            accessor.comparisonPredicate(
                NSExpression(forConstantValue: [isIn]),
                modifier: .any,
                type: .in
            )
        case let .sequence(subFilter):
            build(from: subFilter, accessor: accessor)
        }
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: CollectionFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Collection, Value: Equatable {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath))
    }

    @inlinable
    public static func build<Value>(
        from filter: CollectionFilter<Value>
    ) -> NSPredicate where Value: Collection, Value: Equatable {
        build(from: filter, on: \Value.self)
    }
}
