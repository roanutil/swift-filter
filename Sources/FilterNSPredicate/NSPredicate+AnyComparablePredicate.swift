// NSPredicate+AnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyComparablePredicate {
    /// Creates a NSPredicate from a ComparableFilter
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Value>(
        from filter: ComparableFilter<Value>,
        accessor: NSExpression
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .lessThan(value):
            return accessor.lessThan(NSExpression(forConstantValue: value))
        case let .lessThanOrEqualTo(value):
            return accessor.lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .greaterThan(value):
            return accessor.greaterThan(NSExpression(forConstantValue: value))
        case let .greaterThanOrEqualTo(value):
            return accessor.greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .equatable(equatable):
            return Self.build(from: equatable, accessor: accessor)
        }
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Equatable {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath))
    }

    @inlinable
    public static func build<Value>(
        from filter: ComparableFilter<Value>
    ) -> NSPredicate where Value: Equatable {
        build(from: filter, on: \Value.self)
    }
}
