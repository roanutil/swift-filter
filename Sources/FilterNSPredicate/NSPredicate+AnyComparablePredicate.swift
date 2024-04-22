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
        case let .or(lhs, rhs):
            return .or([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            return .or(predicates.map { build(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            return .and([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            return .and(predicates.map { build(from: $0, on: keyPath) })
        case let .not(inverted):
            return .not(build(from: inverted, on: keyPath))
        case let .equatable(equatable):
            return Self.build(from: equatable, on: keyPath)
        }
    }

    /// Creates a NSPredicate from a ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func build<Root, Value>(
        from filter: ComparableFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
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
        case let .or(lhs, rhs):
            return .or([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            return .or(predicates.map { build(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            return .and([build(from: lhs, on: keyPath), build(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            return .and(predicates.map { build(from: $0, on: keyPath) })
        case let .not(inverted):
            return .not(build(from: inverted, on: keyPath))
        case let .equatable(equatable):
            return Self.build(from: equatable, on: keyPath)
        }
    }
}
