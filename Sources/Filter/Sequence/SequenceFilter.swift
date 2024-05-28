// SequenceFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public struct SequenceFilter<S>: Equatable where S: Sequence, S: Equatable, S.Element: Equatable {
    public let contains: S.Element

    @inlinable
    public init(contains: S.Element) {
        self.contains = contains
    }

    @inlinable
    public static func contains(_ value: S.Element) -> Self {
        self.init(contains: value)
    }

    public typealias Compound = CompoundFilter<Self>
    public typealias Optional = OptionalFilter<Self>
    public typealias OptionalCompound = OptionalFilter<CompoundFilter<Self>>

    @inlinable
    public func map<U>(_ transform: (S.Element) throws -> U.Element) rethrows -> SequenceFilter<U> where U: Sequence,
        U.Element: Equatable
    {
        try .contains(transform(contains))
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

extension SequenceFilter: Hashable where S: Hashable, S.Element: Hashable {}

extension SequenceFilter: Sendable where S: Sendable, S.Element: Sendable {}
