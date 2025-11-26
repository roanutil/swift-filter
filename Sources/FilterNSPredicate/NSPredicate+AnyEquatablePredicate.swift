// NSPredicate+AnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

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
        on keyPath: KeyPath<some Any, Value>
    ) -> NSPredicate where Value: Equatable {
        switch filter {
        case let .equalTo(value):
            NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
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
        }
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<some Any, Value?>
    ) -> NSPredicate where Value: Equatable {
        switch filter {
        case let .equalTo(value):
            NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
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
        }
    }
}
