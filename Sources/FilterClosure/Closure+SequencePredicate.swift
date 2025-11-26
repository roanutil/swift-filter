// Closure+SequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Filter
import Foundation

extension Closure: SequencePredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
    /// Creates a closure `(Self) -> Bool` from a SequenceFilter
    ///
    /// ``SequenceFilter\endsWith`` is implemented by reversing the sequence and using `Sequence.starts(with:)`.
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(from filter: SequenceFilter<Value>,
                             on keyPath: KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    {
        switch filter {
        case let .contains(value):
            return { $0[keyPath: keyPath].contains(value) }
        case let .or(lhs, rhs):
            let lhsClosure = Self.build(from: lhs, on: keyPath)
            let rhsClosure = Self.build(from: rhs, on: keyPath)
            return { lhsClosure($0) || rhsClosure($0) }
        case let .orMulti(filters):
            let predicates = filters.map { Self.build(from: $0, on: keyPath) }
            return { value in
                predicates.contains { $0(value) }
            }
        case let .and(lhs, rhs):
            let lhsClosure = Self.build(from: lhs, on: keyPath)
            let rhsClosure = Self.build(from: rhs, on: keyPath)
            return { lhsClosure($0) && rhsClosure($0) }
        case let .andMulti(filters):
            let predicates = filters.map { Self.build(from: $0, on: keyPath) }
            return { value in predicates.allSatisfy { $0(value) }}
        case let .not(inverted):
            let invertedClosure = Self.build(from: inverted, on: keyPath)
            return { !invertedClosure($0) }
        }
    }
}
