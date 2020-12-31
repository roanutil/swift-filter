//
//  Optional+EquatableOperators.swift
//  
//
//  MIT License
//
//  Copyright (c) 2020 Andrew Roan
//

import Foundation

extension Optional where Wrapped: Equatable {
    /// Creates a closure `(Self) -> Bool` from a EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter.Optional representing the logic of the resulting NSPredicate.
    public static func closure(from filter: EquatableFilter<Wrapped>.Optional) -> ((Self) -> Bool) {
        switch filter {
        case let .orNil(subFilter):
            return { value in
                guard let value = value else { return true }
                return Wrapped.closure(from: subFilter)(value)
            }
        case let .notNil(subFilter):
            return { value in
                guard let value = value else { return false }
                return Wrapped.closure(from: subFilter)(value)
            }
        case .isNil:
            return { $0 == nil }
        }
    }

    /// Creates a NSPredicate from a EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter.Optional representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func predicate<Model>(
        from filter: EquatableFilter<Wrapped>.Optional,
        on keyPath: KeyPath<Model, Self>
    ) -> NSPredicate {
        switch filter {
        case let .orNil(subFilter):
            return NSPredicate.or([
                NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil)),
                Wrapped.predicate(from: subFilter, on: keyPath)
            ])
        case let .notNil(subFilter):
            return NSPredicate.and([
                .not(NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))),
                Wrapped.predicate(from: subFilter, on: keyPath)
            ])
        case .isNil:
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))
        }
    }
}
