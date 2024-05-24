// AnyCompoundPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyCompoundPredicate {
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Root, Value, Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value>,
        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value>) -> Output
    ) -> Output
}

extension AnyCompoundPredicate where Self: AnyEquatablePredicate {
    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<EquatableFilter<Value>>,
        on _: KeyPath<Root, Value>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
    }

    @inlinable
    public static func build<Value>(from filter: CompoundFilter<EquatableFilter<Value>>) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
    }
}

extension AnyCompoundPredicate where Self: AnyComparablePredicate {
    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<ComparableFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> Output {
        build(from: filter, on: keyPath, buildWrapped: build(from:on:))
    }

    @inlinable
    public static func build<Value>(from filter: CompoundFilter<ComparableFilter<Value>>) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:on:))
    }
}
