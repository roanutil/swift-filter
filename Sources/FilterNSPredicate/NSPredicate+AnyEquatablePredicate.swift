// NSPredicate+AnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2023 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyEquatablePredicate {
    /// Creates a NSPredicate from a EquatableFilter
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate where Value: Equatable {
        switch filter {
        case let .equalTo(value):
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
        case .none:
            return NSPredicate(value: true)
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
        }
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Equatable {
        switch filter {
        case let .equalTo(value):
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
        case .none:
            return NSPredicate(value: true)
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
        }
    }
}
