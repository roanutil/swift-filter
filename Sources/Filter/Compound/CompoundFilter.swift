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
    case andMulti([T])
    case not(T)
    case or(T, T)
    case orMulti([T])

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
