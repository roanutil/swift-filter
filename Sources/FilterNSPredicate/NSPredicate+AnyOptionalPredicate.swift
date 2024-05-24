// NSPredicate+AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension NSPredicate: AnyOptionalPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: Filter.OptionalFilter<Wrapped>,
        accessor: NSExpression,
        buildWrapped: (_ from: Wrapped, _ accessor: NSExpression) -> NSPredicate
    ) -> NSPredicate {
        switch filter {
        case .isNil:
            accessor.equalTo(NSExpression(forConstantValue: nil))
        case let .notNil(subFilter):
            if let subFilter {
                accessor.equalTo(NSExpression(forConstantValue: nil)).not()
                    .and(buildWrapped(subFilter, accessor))
            } else {
                accessor.equalTo(NSExpression(forConstantValue: nil)).not()
            }
        case let .orNil(subFilter):
            accessor.equalTo(NSExpression(forConstantValue: nil))
                .or(buildWrapped(subFilter, accessor))
        }
    }

    @inlinable
    public static func build<Root, Value, Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value?>,
        buildWrapped: (_ from: Wrapped, _ accessor: NSExpression) -> NSPredicate
    ) -> NSPredicate {
        build(from: filter, accessor: NSExpression(forKeyPath: keyPath), buildWrapped: buildWrapped)
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: OptionalFilter<EquatableFilter<Value>>,
        on keyPath: KeyPath<Root, Value?>
    ) -> Output {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<EquatableFilter<Value>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>,
        on keyPath: KeyPath<Root, Value?>
    ) -> Output {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<CompoundFilter<EquatableFilter<Value>>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: OptionalFilter<ComparableFilter<Value>>,
        on keyPath: KeyPath<Root, Value?>
    ) -> Output {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<ComparableFilter<Value>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Root, Value>(
        from filter: OptionalFilter<CompoundFilter<ComparableFilter<Value>>>,
        on keyPath: KeyPath<Root, Value?>
    ) -> Output {
        build(from: filter, on: keyPath, buildWrapped: build(from:accessor:))
    }

    @inlinable
    public static func build<Value>(
        from filter: OptionalFilter<CompoundFilter<ComparableFilter<Value>>>
    ) -> Output {
        build(from: filter, on: \Value.self, buildWrapped: build(from:accessor:))
    }
}
