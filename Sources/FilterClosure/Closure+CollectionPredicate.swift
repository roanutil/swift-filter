// Closure+CollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: CollectionPredicate where Value: Collection, Value: Equatable, Value.Element: Equatable {
    /// Creates a closure `(Self) -> Bool` from a CollectionFilter
    ///
    /// For platforms before iOS 16/macOS 13/etc, ``CollectionFilter/isIn`` is implemented by checking if each element
    /// is contained.
    ///
    /// - Parameter filter: An instance of CollectionFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(from filter: CollectionFilter<Value>,
                             on keyPath: KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    {
        switch filter {
        case let .isIn(values):
            if #available(iOS 16, macOS 13, watchOS 9, tvOS 16, macCatalyst 16, *) {
                return { values.contains($0[keyPath: keyPath]) }
            } else {
                return { $0[keyPath: keyPath].allSatisfy { values.contains($0) } }
            }
        case let .sequence(sequenceFilter):
            return Closure.build(from: sequenceFilter, on: keyPath)
        }
    }
}
