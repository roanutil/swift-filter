// AnyEquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyEquatablePredicate {
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: EquatableFilter<Value>, on keyPath: KeyPath<some Any, Value>) -> Output
        where Value: Equatable
}

extension AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: EquatableFilter<some Equatable>) -> Output {
        build(from: filter, on: \.self)
    }
}
