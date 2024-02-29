// OptionalComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value?` types.
public protocol OptionalComparablePredicate: ComparablePredicate, OptionalEquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: ComparableFilter<Value>.Optional, on keyPath: KeyPath<Root, Value?>) -> Output
}

extension OptionalComparablePredicate where Root == Value? {
    /// Builds a predicate of type `Output` for a given `Value?` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>.Optional
    /// - Returns
    ///  - Output
    public static func build(from filter: ComparableFilter<Value>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
