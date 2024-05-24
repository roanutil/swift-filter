// AnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyEquatablePredicate<Accessor, Output> {
    associatedtype Accessor
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: EquatableFilter<Value>, accessor: Accessor) -> Output
        where Value: Equatable
}

extension AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build<Value>(from filter: EquatableFilter<Value>) -> Output where Value: Equatable,
        Accessor == KeyPath<
            Value,
            Value
        >
    {
        build(from: filter, accessor: \.self)
    }
}
