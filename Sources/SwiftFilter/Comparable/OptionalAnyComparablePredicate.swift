// OptionalAnyComparablePredicate.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value?` types.
public protocol OptionalAnyComparablePredicate: AnyComparablePredicate, OptionalAnyEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value?>
    /// - Returns
    ///  - Output
    static func build<Model, Value>(from filter: ComparableFilter<Value>.Optional, on keyPath: KeyPath<Model, Value?>)
        -> Output where Value: Comparable
}

extension OptionalAnyComparablePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>.Optional
    /// - Returns
    ///  - Output
    public static func build<Value>(from filter: ComparableFilter<Value>.Optional) -> Output where Value: Comparable {
        build(from: filter, on: \.self)
    }
}
