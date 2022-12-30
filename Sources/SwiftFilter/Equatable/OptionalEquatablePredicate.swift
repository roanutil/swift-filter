// OptionalEquatablePredicate.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value?` types.
public protocol OptionalEquatablePredicate: EquatablePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: EquatableFilter<Value>.Optional, on keyPath: KeyPath<Root, Value?>) -> Output
}

extension OptionalEquatablePredicate where Root == Value? {
    /// Builds a predicate of type `Output` for a given `Value?` type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>.Optional
    /// - Returns
    ///  - Output
    public static func build(from filter: EquatableFilter<Value>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
