// Optional+Filter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

extension Optional {
    public enum Filter<T> {
        case orNil(T)
        case notNil(T?)
        case isNil

        /// Returns the wrapped Filter from `self`.
        @inlinable
        public var unwrapped: T? {
            switch self {
            case let .orNil(unwrapped):
                return unwrapped
            case let .notNil(unwrapped):
                return unwrapped
            case .isNil:
                return nil
            }
        }
    }
}
