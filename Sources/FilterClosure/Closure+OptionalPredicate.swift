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
        extract: @escaping (Root) -> Value?,
        buildWrapped: @escaping (_ from: Wrapped) -> (@Sendable (Value) -> Bool)
    ) -> (@Sendable (Root) -> Bool) {
        switch filter {
        case let .orNil(subFilter):
            { root in
                guard let value = extract(root) else {
                    return true
                }
                return buildWrapped(subFilter)(value)
            }
        case let .notNil(subFilter):
            { root in
                guard let value = extract(root) else {
                    return false
                }
                if let subFilter {
                    return buildWrapped(subFilter)(value)
                }
                return true
            }
        case .isNil:
            { extract($0) == nil }
        }
    }
}
