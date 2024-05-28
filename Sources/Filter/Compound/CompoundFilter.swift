// CompoundFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public enum CompoundFilter<T> {
    case and(T, T)
    indirect case andNested(Self, Self)
    case andMulti([T])
    indirect case andMultiNested([Self])
    case not(T)
    indirect case notNested(Self)
    case or(T, T)
    indirect case orNested(Self, Self)
    case orMulti([T])
    indirect case orMultiNested([Self])
    case passthrough(T)

    @inlinable
    public func values() -> [T] {
        switch self {
        case let .and(lhs, rhs):
            [lhs, rhs]
        case let .andNested(lhs, rhs):
            lhs.values() + rhs.values()
        case let .andMulti(values):
            values
        case let .andMultiNested(filters):
            filters.flatMap { $0.values() }
        case let .not(value):
            [value]
        case let .notNested(filter):
            filter.values()
        case let .or(lhs, rhs):
            [lhs, rhs]
        case let .orMulti(values):
            values
        case let .orNested(lhs, rhs):
            lhs.values() + rhs.values()
        case let .orMultiNested(filters):
            filters.flatMap { $0.values() }
        case let .passthrough(value):
            [value]
        }
    }

    @inlinable
    public func map<U>(_ transform: (T) throws -> U) rethrows -> CompoundFilter<U> {
        switch self {
        case let .and(lhs, rhs):
            try .and(transform(lhs), transform(rhs))
        case let .andNested(lhs, rhs):
            try .andNested(lhs.map(transform), rhs.map(transform))
        case let .andMulti(values):
            try .andMulti(values.map(transform))
        case let .andMultiNested(filters):
            try .andMultiNested(filters.map { try $0.map(transform) })
        case let .not(value):
            try .not(transform(value))
        case let .notNested(filter):
            try .notNested(filter.map(transform))
        case let .or(lhs, rhs):
            try .or(transform(lhs), transform(rhs))
        case let .orNested(lhs, rhs):
            try .orNested(lhs.map(transform), rhs.map(transform))
        case let .orMulti(values):
            try .orMulti(values.map(transform))
        case let .orMultiNested(filters):
            try .orMultiNested(filters.map { try $0.map(transform) })
        case let .passthrough(value):
            try .passthrough(transform(value))
        }
    }

    // MARK: Compound Nested

    @inlinable
    public func and(_ rhs: Self) -> CompoundFilter<T> {
        .andNested(self, rhs)
    }

    @inlinable
    public static func and(_ lhs: Self, _ rhs: Self) -> CompoundFilter<T> {
        .andNested(lhs, rhs)
    }

    @inlinable
    public static func andMulti(_ filters: [Self]) -> CompoundFilter<T> {
        .andMultiNested(filters)
    }

    @inlinable
    public func not() -> CompoundFilter<T> {
        .notNested(self)
    }

    @inlinable
    public static func not(_ filter: Self) -> CompoundFilter<T> {
        .notNested(filter)
    }

    @inlinable
    public static func or(_ lhs: Self, _ rhs: Self) -> CompoundFilter<T> {
        .orNested(lhs, rhs)
    }

    @inlinable
    public func or(_ rhs: Self) -> CompoundFilter<T> {
        .orNested(self, rhs)
    }

    @inlinable
    public static func orMulti(_ filters: [Self]) -> CompoundFilter<T> {
        .orMultiNested(filters)
    }

    // MARK: Optional

    public typealias Optional = OptionalFilter<Self>

    @inlinable
    public static func isNil() -> OptionalFilter<Self> {
        .isNil
    }

    @inlinable
    public func isNil() -> OptionalFilter<Self> {
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

extension CompoundFilter: Equatable where T: Equatable {}

extension CompoundFilter: Hashable where T: Hashable {}

extension CompoundFilter: Sendable where T: Sendable {}

extension CompoundFilter {
    @inlinable
    public func map<V, O>(_ transform: (V.Element) throws -> O.Element) rethrows -> SequenceFilter<O>.Compound
        where T == SequenceFilter<V>, V: Sequence
    {
        try map { filter in try filter.map(transform) }
    }

    @inlinable
    public func map<V, O>(_ transform: (V) throws -> O) rethrows -> ComparableFilter<O>.Compound
        where T == ComparableFilter<V>
    {
        try map { filter in try filter.map(transform) }
    }

    @inlinable
    public func map<V, O>(_ transform: (V) throws -> O) rethrows -> EquatableFilter<O>.Compound
        where T == EquatableFilter<V>
    {
        try map { filter in try filter.map(transform) }
    }
}
