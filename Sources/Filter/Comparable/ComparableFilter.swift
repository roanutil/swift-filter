// ComparableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// A type that models basic ways of comparing values.
///
/// When using indirect cases for compound comparisons it is best to place more simple comparisons
/// towards the outside and nest more complicated comparisons inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
@frozen
public enum ComparableFilter<T: Comparable>: Equatable {
    case equatable(EquatableFilter<T>)
    case greaterThan(T)
    case greaterThanOrEqualTo(T)
    case lessThan(T)
    case lessThanOrEqualTo(T)

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

    // MARK: Equatable

    @inlinable
    public static func equalTo(_ value: T) -> Self {
        .equatable(.equalTo(value))
    }

    // MARK: Optional

    @inlinable
    public func isNil() -> OptionalFilter<Self> {
        .isNil
    }

    @inlinable
    public static func isNil() -> OptionalFilter<Self> {
        .isNil
    }

    @inlinable
    public func notNil() -> OptionalFilter<Self> {
        .notNil(self)
    }

    @inlinable
    public static func notNil(_ filter: Self?) -> OptionalFilter<Self> {
        .notNil(filter)
    }

    @inlinable
    public func orNil() -> OptionalFilter<Self> {
        .orNil(self)
    }

    @inlinable
    public static func orNil(_ filter: Self) -> OptionalFilter<Self> {
        .orNil(filter)
    }
}

extension ComparableFilter: Hashable where T: Hashable {}

extension ComparableFilter: Sendable where T: Sendable {}
