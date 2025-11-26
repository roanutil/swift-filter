// NSPredicate+OptionalAnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Filter
import Foundation

extension NSPredicate: OptionalAnyComparablePredicate {
    /// Creates a NSPredicate from a ComparableFilter.Optional
    ///
    /// - Parameter filter: An instance of ComparableFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Value>(
        from filter: ComparableFilter<Value>.Optional,
        on keyPath: KeyPath<some Any, Value?>
    ) -> NSPredicate where Value: Comparable {
        switch filter {
        case let .orNil(subFilter):
            return NSPredicate.or([
                NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil)),
                build(from: subFilter, on: keyPath),
            ])
        case let .notNil(subFilter):
            let notNil: NSPredicate = .not(NSExpression(forKeyPath: keyPath)
                .equalTo(NSExpression(forConstantValue: nil)))
            if let subFilter {
                return NSPredicate.and([
                    notNil,
                    build(from: subFilter, on: keyPath),
                ])
            }
            return notNil
        case .isNil:
            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))
        }
    }
}
