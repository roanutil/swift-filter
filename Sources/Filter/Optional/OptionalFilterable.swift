// OptionalFilterable.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

public protocol OptionalFilterable {}

extension OptionalFilterable {
    @inlinable
    public static func orNil(_ filter: Self) -> OptionalFilter<Self> {
        .orNil(filter)
    }

    @inlinable
    public static func notNil(_ filter: Self?) -> OptionalFilter<Self> {
        .notNil(filter)
    }

    @inlinable
    public static func isNil() -> OptionalFilter<Self> {
        .isNil
    }
}
