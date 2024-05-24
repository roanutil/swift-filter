// OptionalFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public enum OptionalFilter<T> {
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

    // MARK: Compound

    @inlinable
    public func and(_ rhs: Self) -> CompoundFilter<Self> {
        .and(self, rhs)
    }

    @inlinable
    public static func and(_ lhs: Self, _ rhs: Self) -> CompoundFilter<Self> {
        .and(lhs, rhs)
    }

    @inlinable
    public static func andMulti(_ filters: [Self]) -> CompoundFilter<Self> {
        .andMulti(filters)
    }

    @inlinable
    public func not() -> CompoundFilter<Self> {
        .not(self)
    }

    @inlinable
    public static func not(_ filter: Self) -> CompoundFilter<Self> {
        .not(filter)
    }

    @inlinable
    public static func or(_ lhs: Self, _ rhs: Self) -> CompoundFilter<Self> {
        .or(lhs, rhs)
    }

    @inlinable
    public func or(_ rhs: Self) -> CompoundFilter<Self> {
        .or(self, rhs)
    }

    @inlinable
    public static func orMulti(_ filters: [Self]) -> CompoundFilter<Self> {
        .orMulti(filters)
    }
}

extension OptionalFilter: Equatable where T: Equatable {}

extension OptionalFilter: Hashable where T: Hashable {}

extension OptionalFilter: Sendable where T: Sendable {}

extension OptionalFilter: Comparable where T: Comparable {
    @inlinable
    public static func < (lhs: OptionalFilter<T>, rhs: OptionalFilter<T>) -> Bool {
        switch (lhs.unwrapped, rhs.unwrapped) {
        case (.none, .none):
            false
        case (.some, .none):
            false
        case (.none, .some):
            true
        case let (.some(lhsValue), .some(rhsValue)):
            lhsValue < rhsValue
        }
    }
}
