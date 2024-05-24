// AnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyComparablePredicate: AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: ComparableFilter<Value>, accessor: Accessor) -> Output
        where Value: Comparable
}

extension AnyComparablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build<Value>(from filter: ComparableFilter<Value>) -> Output where Value: Comparable,
        Accessor == KeyPath<
            Value,
            Value
        >
    {
        build(from: filter, accessor: \.self)
    }
}
