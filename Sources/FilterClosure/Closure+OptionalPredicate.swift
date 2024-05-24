// Closure+OptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter

extension Closure: OptionalPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        on keyPath: KeyPath<Root, Value?>,
        buildWrapped: @escaping (Wrapped, KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .orNil(subFilter):
            { root in
                guard root[keyPath: keyPath] != nil else {
                    return true
                }
                return buildWrapped(subFilter, keyPath.appending(path: \.unsafelyUnwrapped))(root)
            }
        case let .notNil(subFilter):
            { root in
                guard root[keyPath: keyPath] != nil else {
                    return false
                }
                if let subFilter {
                    return buildWrapped(subFilter, keyPath.appending(path: \.unsafelyUnwrapped))(root)
                }
                return true
            }
        case .isNil:
            { $0[keyPath: keyPath] == nil }
        }
    }
}
