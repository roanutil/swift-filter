// NSPredicate+AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

// extension NSPredicate {
//    @inlinable
//    public static func build<Root, Value, Wrapped>(
//        from filter: OptionalFilter<Wrapped>,
//        on keyPath: KeyPath<Root, Value?>,
//        buildWrapped: @escaping (Wrapped, KeyPath<Root, Value>) -> NSPredicate
//    ) -> NSPredicate {
//        switch filter {
//        case let .orNil(subFilter):
//
//            buildWrapped(subFilter, keyPath)
//            { root in
//                guard root[keyPath: keyPath] != nil else {
//                    return true
//                }
//                return buildWrapped(subFilter, keyPath.appending(path: \.unsafelyUnwrapped))(root)
//            }
//        case let .notNil(subFilter):
//            { root in
//                guard root[keyPath: keyPath] != nil else {
//                    return false
//                }
//                if let subFilter {
//                    return buildWrapped(subFilter, keyPath.appending(path: \.unsafelyUnwrapped))(root)
//                }
//                return true
//            }
//        case .isNil:
//            { $0[keyPath: keyPath] == nil }
//        }
//    }
// }
