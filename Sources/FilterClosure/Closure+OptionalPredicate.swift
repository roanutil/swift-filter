// Closure+OptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: OptionalPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value?>,
        buildWrapped: @escaping (_ from: Wrapped, _ on: KeyPath<Root, Value?>) -> (@Sendable (Root) -> Bool)
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .orNil(subFilter):
            { root in
                buildWrapped(subFilter, keyPath)(root)
            }
        case let .notNil(subFilter):
            { root in
                guard root[keyPath: keyPath] != nil else {
                    return false
                }
                if let subFilter {
                    return buildWrapped(subFilter, keyPath)(root)
                }
                return true
            }
        case .isNil:
            { $0[keyPath: keyPath] == nil }
        }
    }
}
