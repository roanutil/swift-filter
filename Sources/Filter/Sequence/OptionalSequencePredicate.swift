// OptionalSequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value?` types.
public protocol OptionalSequencePredicate: SequencePredicate {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>.Optional
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: SequenceFilter<Value>.Optional, on keyPath: KeyPath<Root, Value?>) -> Output
}

extension OptionalSequencePredicate where Root == Value? {
    /// Builds a predicate of type `Output` for a given `Value?` type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>.Optional
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: SequenceFilter<Value>.Optional) -> Output {
        build(from: filter, on: \.self)
    }
}
