// OptionalAnySequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value?` types.
public protocol OptionalAnySequencePredicate: AnySequencePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value?>
    /// - Returns
    ///  - Output
    static func build<Model, Value>(from filter: SequenceFilter<Value>.Optional, on keyPath: KeyPath<Model, Value?>)
        -> Output where Value: Sequence
}

extension OptionalAnySequencePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>.Optional
    /// - Returns
    ///  - Output
    @inlinable
    public static func build<Value>(from filter: SequenceFilter<Value>.Optional) -> Output where Value: Sequence {
        build(from: filter, on: \.self)
    }
}
