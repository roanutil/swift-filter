// CompoundFilterable.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

public protocol CompoundFilterable {}

extension CompoundFilterable {
    @inlinable
    public static func and(_ lhs: Self, _ rhs: Self) -> CompoundFilter<Self> {
        .and(lhs, rhs)
    }

    @inlinable
    public static func andMulti(_ filters: [Self]) -> CompoundFilter<Self> {
        .andMulti(filters)
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
    public static func orMulti(_ filters: [Self]) -> CompoundFilter<Self> {
        .orMulti(filters)
    }
}
