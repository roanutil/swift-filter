// ComparablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2022 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol ComparablePredicate: EquatablePredicate where Value: Comparable {
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: ComparableFilter<Value>, on keyPath: KeyPath<Root, Value>) -> Output
}

extension ComparablePredicate where Root == Value {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: ComparableFilter<Value>
    /// - Returns
    ///  - Output
    public static func build(from filter: ComparableFilter<Value>) -> Output {
        build(from: filter, on: \.self)
    }
}
