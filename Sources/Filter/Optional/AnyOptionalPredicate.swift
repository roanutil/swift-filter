// AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

// AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
// public protocol AnyOptionalPredicate {
//    associatedtype Output
//    /// Builds a predicate of type `Output` for a given property on a root type.
//    /// - Parameters
//    ///  - filter: EquatableFilter<Value>
//    ///  - keyPath: KeyPath<Root, Value>
//    /// - Returns
//    ///  - Output
//    static func build<Root, Value, Wrapped>(
//        from filter: OptionalFilter<Wrapped>,
//        on keyPath: KeyPath<Root, Value?>,
//        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value?>) -> Output
//    ) -> Output
// }

// extension AnyOptionalPredicate where Self: AnyEquatablePredicate {
//    @inlinable
//    public static func build<Root, Value>(
//        from filter: OptionalFilter<EquatableFilter<Value>>,
//        on keyPath: KeyPath<Root, Value?>
//    ) -> Output {
//        build(from: filter, on: keyPath) { wrapped, keyPath in
//            build(from: wrapped, on: keyPath)
//        }
//    }
//
//    @inlinable
//    public static func build<Value>(from filter: OptionalFilter<EquatableFilter<Value?>>) -> Output {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
//
// extension AnyOptionalPredicate where Self: AnyComparablePredicate {
//    @inlinable
//    public static func build<Root, Value>(
//        from filter: OptionalFilter<ComparableFilter<Value>>,
//        on keyPath: KeyPath<Root, Value?>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build<Value>(from filter: OptionalFilter<ComparableFilter<Value>>) -> Output {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
