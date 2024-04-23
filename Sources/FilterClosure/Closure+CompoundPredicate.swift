// Closure+CompoundPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: CompoundPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: CompoundFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value>,
        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .and(lhs, rhs):
            let lhsClosure = buildWrapped(lhs, keyPath)
            let rhsClosure = buildWrapped(rhs, keyPath)
            return { lhsClosure($0) && rhsClosure($0) }
        case let .andMulti(filters):
            let predicates = filters.map { buildWrapped($0, keyPath) }
            return { value in
                predicates.allSatisfy { $0(value) }
            }
        case let .not(filter):
            let invertedClosure = buildWrapped(filter, keyPath)
            return { !invertedClosure($0) }
        case let .or(lhs, rhs):
            let lhsClosure = buildWrapped(lhs, keyPath)
            let rhsClosure = buildWrapped(rhs, keyPath)
            return { lhsClosure($0) || rhsClosure($0) }
        case let .orMulti(filters):
            let predicates = filters.map { buildWrapped($0, keyPath) }
            return { value in
                predicates.contains { $0(value) }
            }
        }
    }
}
