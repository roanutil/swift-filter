// OptionalCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value?` types.
public protocol OptionalCollectionPredicate: CollectionPredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: CollectionFilter<Value>.Optional, on keyPath: KeyPath<Root, Value?>) -> Output
}

extension OptionalCollectionPredicate where Root == Value? {
    /// Builds a predicate of type `Output` for a given `Value?` type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>.Optional
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: CollectionFilter<Value>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
