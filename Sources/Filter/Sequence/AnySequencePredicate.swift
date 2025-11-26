// AnySequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnySequencePredicate {
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Value>(from filter: SequenceFilter<Value>, on keyPath: KeyPath<some Any, Value>) -> Output
        where Value: Sequence
}

extension AnySequencePredicate {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: SequenceFilter<some Sequence>) -> Output {
        build(from: filter, on: \.self)
    }
}
