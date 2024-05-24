// AnyCompoundPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyCompoundPredicate<Accessor, Output> {
    associatedtype Accessor
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        accessor: Accessor,
        buildWrapped: (_ from: Wrapped, _ accessor: Accessor) -> Output
    ) -> Output
}

extension AnyCompoundPredicate where Self: AnyEquatablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<EquatableFilter<Value>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}

extension AnyCompoundPredicate where Self: AnyComparablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<ComparableFilter<Value>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}
