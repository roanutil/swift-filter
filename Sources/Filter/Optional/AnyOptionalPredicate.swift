// AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// Builds predicates where the output is type-erased of the incoming `Root` and `Value` types.
public protocol AnyOptionalPredicate<Accessor, Output> {
    associatedtype Accessor
    associatedtype Output
    /// Builds a predicate of type `Output` for a given property on a root type.
    /// - Parameters
    ///  - filter: EquatableFilter<Value>
    ///  - keyPath: KeyPath<Root, Value>
    /// - Returns
    ///  - Output
    static func build<Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        accessor: Accessor,
        buildWrapped: (_ from: Wrapped, _ accessor: Accessor) -> Output
    ) -> Output
}

extension AnyOptionalPredicate where Self: AnyEquatablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<EquatableFilter<Value>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}

extension AnyOptionalPredicate where Self: AnyComparablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<ComparableFilter<Value>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}

extension AnyOptionalPredicate where Self: AnyCompoundPredicate, Self: AnyEquatablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}

extension AnyOptionalPredicate where Self: AnyCompoundPredicate, Self: AnyComparablePredicate {
    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<CompoundFilter<ComparableFilter<Value>>>,
        accessor: Accessor
    ) -> Output {
        build(from: filter, accessor: accessor, buildWrapped: build(from:accessor:))
    }
}
