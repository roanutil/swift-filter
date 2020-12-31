//
//  Comparable+FilterOperators.swift
//  
//
//  MIT License
//
//  Copyright (c) 2020 Andrew Roan
//

import Foundation

extension Comparable {
    /// Creates a NSPredicate from a ComparableFilter that is wrapped by ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func predicate<Model>(
        from filter: ComparableFilter<Self>,
        on keyPath: KeyPath<Model, Self?>
    ) -> NSPredicate {
        switch filter {
        case .lessThan(let value):
            return NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case .lessThanOrEqualTo(let value):
            return NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case .greaterThan(let value):
            return NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case .greaterThanOrEqualTo(let value):
            return NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case .none:
            return NSPredicate(value: true)
        case let .or(lhs, rhs):
            return .or([predicate(from: lhs, on: keyPath), predicate(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            return .or(predicates.map { predicate(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            return .and([predicate(from: lhs, on: keyPath), predicate(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            return .and(predicates.map { predicate(from: $0, on: keyPath) })
        case let .not(inverted):
            return .not(predicate(from: inverted, on: keyPath))
        case let .equatable(equatable):
            return Self.predicate(from: equatable, on: keyPath)
        }
    }

    /// Creates a NSPredicate from a ComparableFilter
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func predicate<Model>(
        from filter: ComparableFilter<Self>,
        on keyPath: KeyPath<Model, Self>
    ) -> NSPredicate {
        switch filter {
        case .lessThan(let value):
            return NSExpression(forKeyPath: keyPath).lessThan(NSExpression(forConstantValue: value))
        case .lessThanOrEqualTo(let value):
            return NSExpression(forKeyPath: keyPath).lessThanOrEqualTo(NSExpression(forConstantValue: value))
        case .greaterThan(let value):
            return NSExpression(forKeyPath: keyPath).greaterThan(NSExpression(forConstantValue: value))
        case .greaterThanOrEqualTo(let value):
            return NSExpression(forKeyPath: keyPath).greaterThanOrEqualTo(NSExpression(forConstantValue: value))
        case .none:
            return NSPredicate(value: true)
        case let .or(lhs, rhs):
            return .or([predicate(from: lhs, on: keyPath), predicate(from: rhs, on: keyPath)])
        case let .orMulti(predicates):
            return .or(predicates.map { predicate(from: $0, on: keyPath) })
        case let .and(lhs, rhs):
            return .and([predicate(from: lhs, on: keyPath), predicate(from: rhs, on: keyPath)])
        case let .andMulti(predicates):
            return .and(predicates.map { predicate(from: $0, on: keyPath) })
        case let .not(inverted):
            return .not(predicate(from: inverted, on: keyPath))
        case let.equatable(equatable):
            return Self.predicate(from: equatable, on: keyPath)
        }
    }

    /// Creates a closure `(Self) -> Bool` from a ComparableFilter
    ///
    /// - Parameter filter: An instance of ComparableFilter representing the logic of the resulting NSPredicate.
    public static func closure(from filter: ComparableFilter<Self>) -> ((Self) -> Bool) {
        switch filter {
        case .lessThan(let bound):
            return { $0 < bound }
        case .lessThanOrEqualTo(let bound):
            return { $0 <= bound }
        case .greaterThan(let bound):
            return { $0 > bound }
        case .greaterThanOrEqualTo(let bound):
            return { $0 >= bound }
        case .none:
            return { _ in true }
        case let .or(lhs, rhs):
            let lhsClosure = Self.closure(from: lhs)
            let rhsClosure = Self.closure(from: rhs)
            return { lhsClosure($0) || rhsClosure($0) }
        case let .orMulti(filters):
            let predicates = filters.map { Self.closure(from: $0) }
            return { value in
                predicates.contains { $0(value) }
            }
        case let .and(lhs, rhs):
            let lhsClosure = Self.closure(from: lhs)
            let rhsClosure = Self.closure(from: rhs)
            return { lhsClosure($0) && rhsClosure($0) }
        case let .andMulti(filters):
            let predicates = filters.map { Self.closure(from: $0) }
            return { value in predicates.allSatisfy { $0(value) }}
        case let .not(inverted):
            let invertedClosure = Self.closure(from: inverted)
            return { !invertedClosure($0) }
        case let.equatable(equatable):
            return Self.closure(from: equatable)
        }
    }
}
