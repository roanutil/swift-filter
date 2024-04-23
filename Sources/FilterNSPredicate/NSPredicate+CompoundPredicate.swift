// NSPredicate+CompoundPredicate.swift
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
    public static func build<Root, Value, Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value>,
        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value>) -> NSPredicate
    ) -> NSPredicate {
        switch filter {
        case let .and(lhs, rhs):
            buildWrapped(lhs, keyPath).and(buildWrapped(rhs, keyPath))
        case let .andMulti(filters):
            .and(filters.map { buildWrapped($0, keyPath) })
        case let .not(filter):
            .not(buildWrapped(filter, keyPath))
        case let .or(lhs, rhs):
            buildWrapped(lhs, keyPath).or(buildWrapped(rhs, keyPath))
        case let .orMulti(filters):
            .or(filters.map { buildWrapped($0, keyPath) })
        }
    }
}
