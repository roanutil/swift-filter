// OptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol OptionalPredicate<Root, Value> {
    /// The predicate this type builds
    associatedtype Output
    /// Root type being filtered
    associatedtype Root
    /// Property type on `Root` being filtered
    associatedtype Value

    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: OptionalFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        extract: @escaping (Root) -> Value?,
        buildWrapped: @escaping (_ from: Wrapped, _ extract: @escaping (Root) -> Value?) -> Output
    ) -> Output
}

extension OptionalPredicate where Self: EquatablePredicate {
    @inlinable
    public static func build(
        from filter: OptionalFilter<EquatableFilter<Value>>,
        extract: @escaping (Root) -> Value?
    ) -> Output {
        build(from: filter, extract: extract, buildWrapped: build(from:extract:))
    }
}

//extension OptionalPredicate where Self: CompoundPredicate, Self: EquatablePredicate {
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//}
