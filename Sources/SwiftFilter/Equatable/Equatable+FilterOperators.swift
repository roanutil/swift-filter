//
//  Equatable+FilterOperators.swift
//  
//
//  MIT License
//
//  Copyright (c) 2020 Andrew Roan
//

import Foundation

extension Equatable {
    /// Creates a NSPredicate from a EquatableFilter
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func predicate<Model>(
        from filter: EquatableFilter<Self>,
        on keyPath: KeyPath<Model, Self>
    ) -> NSPredicate {
        switch filter {
        case .equalTo(let value):
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
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
        }
    }

    /// Creates a NSPredicate from a EquatableFilter that is wrapped by EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func predicate<Model>(
            from filter: EquatableFilter<Self>,
            on keyPath: KeyPath<Model, Self?>
        ) -> NSPredicate {
            switch filter {
            case .equalTo(let value):
                return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: value))
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
            }
        }

    /// Creates a closure `(Self) -> Bool` from a EquatableFilter
    ///
    /// - Parameter filter: An instance of EquatableFilter representing the logic of the resulting NSPredicate.
    public static func closure(from filter: EquatableFilter<Self>) -> ((Self) -> Bool) {
        switch filter {
        case .equalTo(let requiredValue):
            return { $0 == requiredValue }
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
        }
    }
}
