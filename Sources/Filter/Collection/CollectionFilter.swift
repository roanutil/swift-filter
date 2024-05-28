// CollectionFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public enum CollectionFilter<C> where C: Collection {
    case isIn(C)
    case sequence(SequenceFilter<C>)

    public typealias Compound = CompoundFilter<Self>
    public typealias Optional = OptionalFilter<Self>
    public typealias OptionalCompound = OptionalFilter<CompoundFilter<Self>>

    @inlinable
    public func map<U>(
        _ transform: (C) throws -> U,
        sequence sequenceTransform: (C.Element) throws -> U.Element
    ) rethrows -> CollectionFilter<U>
        where U: Collection
    {
        switch self {
        case let .isIn(value):
            try .isIn(transform(value))
        case let .sequence(sequence):
            try .sequence(sequence.map(sequenceTransform))
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

extension CollectionFilter: Equatable where C: Equatable, C.Element: Equatable {}

extension CollectionFilter: Hashable where C: Hashable, C.Element: Hashable {}

extension CollectionFilter: Sendable where C: Sendable, C.Element: Sendable {}
