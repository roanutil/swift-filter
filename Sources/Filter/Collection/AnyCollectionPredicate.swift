// AnyCollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyCollectionPredicate: AnySequencePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: CollectionFilter<Value>, accessor: Accessor) -> Output
        where Value: Collection
}

extension AnyCollectionPredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build<Value>(from filter: CollectionFilter<Value>) -> Output where Value: Collection,
        Accessor == KeyPath<
            Value,
            Value
        >
    {
        build(from: filter, accessor: \.self)
    }
}
