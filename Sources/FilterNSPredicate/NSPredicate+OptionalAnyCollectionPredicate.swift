// NSPredicate+OptionalAnyCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: OptionalAnyCollectionPredicate {
    /// Creates a NSPredicate from a CollectionFilter.Optional
    ///
    /// - Parameter filter: An instance of CollectionFilter.Optional representing the logic of the resulting
    /// NSPredicate.
    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
    @inlinable
    public static func build<Root, Value>(
        from filter: CollectionFilter<Value>.Optional,
        on keyPath: KeyPath<Root, Value?>
    ) -> NSPredicate where Value: Collection, Value: Equatable, Value.Element: Equatable {
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
