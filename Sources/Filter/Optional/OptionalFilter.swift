// OptionalFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public enum OptionalFilter<T> {
    case isNil
    case notNil(T?)
    case orNil(T)

    /// Returns the wrapped Filter from `self`.
    @inlinable
    public var unwrapped: T? {
        switch self {
        case .isNil:
            return nil
        case let .notNil(unwrapped):
            return unwrapped
        case let .orNil(unwrapped):
            return unwrapped
        }
    }

    @inlinable
    public func map<U>(_ transform: (T) throws -> U) rethrows -> OptionalFilter<U> {
        switch self {
        case .isNil:
            .isNil
        case let .notNil(value):
            if let value {
                try .notNil(transform(value))
            } else {
                .notNil(nil)
            }
        case let .orNil(value):
            try .orNil(transform(value))
        }
    }
}

extension OptionalFilter: Equatable where T: Equatable {}

extension OptionalFilter: Hashable where T: Hashable {}

extension OptionalFilter: Sendable where T: Sendable {}
