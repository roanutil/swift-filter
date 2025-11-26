// OptionalAnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value?` types.
public protocol OptionalAnyEquatablePredicate: AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value?>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: EquatableFilter<Value>.Optional, on keyPath: KeyPath<some Any, Value?>)
        -> Output where Value: Equatable
}

extension OptionalAnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>.Optional
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: EquatableFilter<some Equatable>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
