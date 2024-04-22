// Closure+ComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: ComparablePredicate where Value: Comparable {
    /// Creates a closure `(Self) -> Bool` from a ComparableFilter
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    public static func build(from filter: ComparableFilter<Value>,
                             on keyPath: KeyPath<Root, Value>) -> ((Root) -> Bool)
    {
        switch filter {
        case let .lessThan(bound):
            return { $0[keyPath: keyPath] < bound }
        case let .lessThanOrEqualTo(bound):
            return { $0[keyPath: keyPath] <= bound }
        case let .greaterThan(bound):
            return { $0[keyPath: keyPath] > bound }
        case let .greaterThanOrEqualTo(bound):
            return { $0[keyPath: keyPath] >= bound }
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
        case let .equatable(equatable):
            return Self.build(from: equatable, on: keyPath)
        }
    }
}
