// AnyCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyCollectionPredicate {
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Root, Value>(from filter: CollectionFilter<Value>, on keyPath: KeyPath<Root, Value>) -> Output
        where Value: Collection
}

extension AnyCollectionPredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build<Value>(from filter: CollectionFilter<Value>) -> Output where Value: Collection {
        build(from: filter, on: \.self)
    }
}
