// EquatablePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol EquatablePredicate<Root, Value> where Value: Equatable {
    /// The predicate this type builds
    associatedtype Output
    /// Root type being filtered
    associatedtype Root
    /// Property type on `Root` being filtered
    associatedtype Value

    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build(from filter: EquatableFilter<Value>, extract: @escaping (Root) -> Value) -> Output
    
    static func build(from filter: EquatableFilter<Optional<Value>>, extract: @escaping (Root) -> Optional<Value>) -> Output
}

extension EquatablePredicate where Root == Value {
    /// Builds a predicate of type `Output` for a given `Value` type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    /// - Returns
    ///  - Output
    @inlinable
    public static func build(from filter: EquatableFilter<Value>) -> Output {
        build(from: filter, extract: { $0 })
    }
    
    @inlinable
    public static func build(from filter: EquatableFilter<Optional<Value>>) -> Output {
        build(from: filter, extract: { $0 })
    }
}
