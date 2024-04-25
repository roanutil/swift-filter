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
        switch filter {
        case let .contains(value):
            NSExpression(forKeyPath: keyPath).comparisonPredicate(
                NSExpression(forConstantValue: [value]),
                modifier: .any,
                type: .in
            )
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

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by SequenceFilter.Optional
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: SequenceFilter<Value>,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
        switch filter {
        case let .contains(value):
            NSExpression(forKeyPath: keyPath).comparisonPredicate(
                NSExpression(forConstantValue: [value]),
                modifier: .any,
                type: .in
            )
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
