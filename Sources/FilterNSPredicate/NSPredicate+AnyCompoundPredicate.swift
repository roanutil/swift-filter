// NSPredicate+AnyCompoundPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyCompoundPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        accessor: NSExpression,
        buildWrapped: (_ from: Wrapped, _ accessor: NSExpression) -> NSPredicate
    ) -> NSPredicate {
        switch filter {
        case let .and(lhs, rhs):
            buildWrapped(lhs, accessor).and(buildWrapped(rhs, accessor))
        case let .andMulti(filters):
            .and(filters.map { buildWrapped($0, accessor) })
        case let .not(filter):
            .not(buildWrapped(filter, accessor))
        case let .or(lhs, rhs):
            buildWrapped(lhs, accessor).or(buildWrapped(rhs, accessor))
        case let .orMulti(filters):
            .or(filters.map { buildWrapped($0, accessor) })
        }
    }

    @inlinable
    public static func build<Root, Value, Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value>,
        buildWrapped: (_ from: Wrapped, _ accessor: NSExpression) -> NSPredicate
    ) -> NSPredicate {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath), buildWrapped: buildWrapped)
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<EquatableFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<EquatableFilter<Value>>
    ) -> NSPredicate {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<ComparableFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<ComparableFilter<Value>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<SequenceFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<SequenceFilter<Value>>
    ) -> NSPredicate {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: CompoundFilter<CollectionFilter<Value>>,
        on keyPath: KeyPath<Root, Value>
    ) -> NSPredicate {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: CompoundFilter<CollectionFilter<Value>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }
}
