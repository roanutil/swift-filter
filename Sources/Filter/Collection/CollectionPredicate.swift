// CollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol CollectionPredicate {
    /// The predicate this type builds
    associatedtype Output
    /// Root type being filtered
    associatedtype Root
    /// Property type on `Root` being filtered
    associatedtype Value: Collection where Value: Equatable, Value.Element: Equatable

    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: CollectionFilter<Value>, on keyPath: KeyPath<Root, Value>) -> Output
}

extension CollectionPredicate where Root == Value {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: CollectionFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: CollectionFilter<Value>) -> Output {
        build(from: filter, on: \.self)
    }
}
