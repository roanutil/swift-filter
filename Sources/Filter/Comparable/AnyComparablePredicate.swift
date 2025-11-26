// AnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyComparablePredicate: AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: ComparableFilter<Value>, on keyPath: KeyPath<some Any, Value>) -> Output
        where Value: Comparable
}

extension AnyComparablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: ComparableFilter<some Comparable>) -> Output {
        build(from: filter, on: \.self)
    }
}
