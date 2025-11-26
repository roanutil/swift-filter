// SequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol SequencePredicate {
    /// The predicate this type builds
    associatedtype Output
    /// Root type being filtered
    associatedtype Root
    /// Property type on `Root` being filtered
    associatedtype Value: Sequence where Value: Equatable, Value.Element: Equatable

    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: SequenceFilter<Value>, on keyPath: KeyPath<Root, Value>) -> Output
}

extension SequencePredicate where Root == Value {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: SequenceFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: SequenceFilter<Value>) -> Output {
        build(from: filter, on: \.self)
    }
}
