// OptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

//// OptionalPredicate.swift
//// Filter
////
////
//// MIT License
////
//// Copyright © 2024 Andrew Roan
//
// import Foundation
//
///// Builds predicates where the output is type constrained by the incoming `Root` and `Value` types.
// public protocol OptionalPredicate<Root, Value> {
//    /// The predicate this type builds
//    associatedtype Output
//    /// Root type being filtered
//    associatedtype Root
//    /// Property type on `Root` being filtered
//    associatedtype Value
//
//    /// Builds a predicate of type `Output` for a given property on a root type.
//    /// - Parameters
//    ///  - filter: OptionalFilter<Value>
//    ///  - keyPath: KeyPath<Root, Value>
//    /// - Returns
//    ///  - Output
//    static func build<Wrapped>(
//        from filter: OptionalFilter<Wrapped>,
//        on keyPath: KeyPath<Root, Value>,
//        buildWrapped: @escaping (_ from: Wrapped, _ on: KeyPath<Root, Value>) -> Output
//    ) -> Output
// }
//
// extension OptionalPredicate where Self: EquatablePredicate {
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<EquatableFilter<Value>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<EquatableFilter<Value>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
//
// extension OptionalPredicate where Self: ComparablePredicate {
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<ComparableFilter<Value>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<ComparableFilter<Value>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
//
// extension OptionalPredicate where Self: CompoundPredicate, Self: EquatablePredicate {
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
//
// extension OptionalPredicate where Self: CompoundPredicate, Self: ComparablePredicate {
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<CompoundFilter<ComparableFilter<Value>>>,
//        on keyPath: KeyPath<Root, Value>
//    ) -> Output {
//        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
//    }
//
//    @inlinable
//    public static func build(
//        from filter: OptionalFilter<CompoundFilter<ComparableFilter<Value>>>
//    ) -> Output where Root == Value {
//        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
//    }
// }
