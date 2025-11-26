// NSPredicate+AnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

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
        on keyPath: KeyPath<some Any, Value>
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .lessThan(value):
            NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case let .lessThanOrEqualTo(value):
            NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .greaterThan(value):
            NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case let .greaterThanOrEqualTo(value):
            NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .or(lhs, rhs):
            .or([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            .or(predicates.map { build(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            .and([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            .and(predicates.map { build(from: $0, on: keyPath) })
        case let .not(inverted):
            .not(build(from: inverted, on: keyPath))
        case let .equatable(equatable):
            Self.build(from: equatable, on: keyPath)
        }
    }

    /// Creates a NSPredicate from a ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Value>(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<some Any, Value?>
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .lessThan(value):
            NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case let .lessThanOrEqualTo(value):
            NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .greaterThan(value):
            NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case let .greaterThanOrEqualTo(value):
            NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case let .or(lhs, rhs):
            .or([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            .or(predicates.map { build(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            .and([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            .and(predicates.map { build(from: $0, on: keyPath) })
        case let .not(inverted):
            .not(build(from: inverted, on: keyPath))
        case let .equatable(equatable):
            Self.build(from: equatable, on: keyPath)
        }
    }
}
