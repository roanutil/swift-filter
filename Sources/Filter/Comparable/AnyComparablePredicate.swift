// AnyComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyComparablePredicate: AnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Root, Value>(from filter: ComparableFilter<Value>, on keyPath: KeyPath<Root, Value>) -> Output
        where Value: Comparable
}

extension AnyComparablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    /// - Returns
    ///  - Output
    public static func build<Value>(from filter: ComparableFilter<Value>) -> Output where Value: Comparable {
        build(from: filter, on: \.self)
    }
}
