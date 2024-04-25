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
    public static func build<Root, Value>(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .lessThan(value):
            return NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case let .lessThanOrEqualTo(value):
            return NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .greaterThan(value):
            return NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case let .greaterThanOrEqualTo(value):
            return NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .equatable(equatable):
            return Self.build(from: equatable, on: keyPath)
        }
    }

    /// Creates a NSPredicate from a ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<Root, Optional<Value>>
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .lessThan(value):
            return NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case let .lessThanOrEqualTo(value):
            return NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .greaterThan(value):
            return NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case let .greaterThanOrEqualTo(value):
            return NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .equatable(equatable):
            return Self.build(from: equatable, on: keyPath)
        }
    }
}
