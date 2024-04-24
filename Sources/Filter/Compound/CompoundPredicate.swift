// CompoundPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
public protocol CompoundPredicate<Root, Value> {
    /// The predicate this type builds
    associatedtype Output
    /// Root type being filtered
    associatedtype Root
    /// Property type on `Root` being filtered
    associatedtype Value

    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: CompoundFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func buildCompound<Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value>,
        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value>) -> Output
    ) -> Output
}

extension CompoundPredicate where Self: EquatablePredicate, Value: Equatable {
    @inlinable
    public static func buildCompound(
        from filter: CompoundFilter<EquatableFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> Output {
        buildCompound(from: filter, on: keyPath, buildWrapped: buildEquatable(from:on:))
    }

    @inlinable
    public static func buildCompound(
        from filter: CompoundFilter<EquatableFilter<Value>>
    ) -> Output where Root == Value {
        buildCompound(from: filter, on: \Value.self, buildWrapped: buildEquatable(from:on:))
    }
}

extension CompoundPredicate where Self: ComparablePredicate, Value: Comparable {
    @inlinable
    public static func buildCompound(
        from filter: CompoundFilter<ComparableFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> Output {
        buildCompound(from: filter, on: keyPath, buildWrapped: buildComparable(from:on:))
    }

    @inlinable
    public static func buildCompound(
        from filter: CompoundFilter<ComparableFilter<Value>>
    ) -> Output where Root == Value {
        buildCompound(from: filter, on: \Value.self, buildWrapped: buildComparable(from:on:))
    }
}

// extension CompoundPredicate where Self: OptionalPredicate, Self: EquatablePredicate {
//    @inlinable
//    public static func build(
//        from filter: CompoundFilter<OptionalFilter<EquatableFilter<Value>>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: CompoundFilter<OptionalFilter<EquatableFilter<Value>>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
//
// extension CompoundPredicate where Self: OptionalPredicate, Self: ComparablePredicate {
//    @inlinable
//    public static func build(
//        from filter: CompoundFilter<OptionalFilter<ComparableFilter<Value>>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: CompoundFilter<OptionalFilter<ComparableFilter<Value>>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
