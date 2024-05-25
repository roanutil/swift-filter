// EquatableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

/// A type that models basic ways of equating values.
///
/// When using indirect cases for compound statements it is best to place more simple operations
/// towards the outside and nest more complicated operations inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
@frozen
public struct EquatableFilter<T: Equatable>: Equatable {
    public let equalTo: T

    @inlinable
    public init(equalTo: T) {
        self.equalTo = equalTo
    }

    @inlinable
    public static func equalTo(_ value: T) -> Self {
        self.init(equalTo: value)
    }

    public typealias Compound = CompoundFilter<Self>
    public typealias Optional = OptionalFilter<Self>
    public typealias OptionalCompount = OptionalFilter<CompoundFilter<Self>>

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

extension EquatableFilter: Hashable where T: Hashable {}

extension EquatableFilter: Sendable where T: Sendable {}
