// NSPredicate+OptionalAnyEquatablePredicate.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import Foundation
import SwiftFilter

extension NSPredicate: OptionalAnyEquatablePredicate {
    /// Creates a NSPredicate from a EquatableFilter.Optional
    ///
    /// - Parameter filter: An instance of EquatableFilter.Optional representing the logic of the resulting NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    public static func build<Root, Value>(
        from filter: EquatableFilter<Value>.Optional,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Equatable {
        switch filter {
        case let .orNil(subFilter):
            return NSPredicate.or([
                NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil)),
                build(from: subFilter, on: keyPath),
            ])
        case let .notNil(subFilter):
            return NSPredicate.and([
                .not(NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))),
                build(from: subFilter, on: keyPath),
            ])
        case .isNil:
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))
        }
    }
}
