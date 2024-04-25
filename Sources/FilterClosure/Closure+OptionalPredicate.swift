//
//  File.swift
//  
//
//  Created by andrew on 4/24/24.
//

import Filter
import Foundation

extension Closure: OptionalPredicate {
    @inlinable
    public static func build<Wrapped>(
        from filter: OptionalFilter<Wrapped>,
        extract: @escaping (Root) -> Value?,
        buildWrapped: @escaping (_ from: Wrapped, _ extract: @escaping (Root) -> Value?) -> (@Sendable (Root) -> Bool)
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
