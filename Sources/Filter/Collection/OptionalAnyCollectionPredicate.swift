// OptionalAnyCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value?` types.
public protocol OptionalAnyCollectionPredicate: AnyCollectionPredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value?>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: CollectionFilter<Value>.Optional, on keyPath: KeyPath<some Any, Value?>)
        -> Output where Value: Collection
}

extension OptionalAnyCollectionPredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>.Optional
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: CollectionFilter<some Collection>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
