// EquatableFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

/// A type that models basic ways of equating values.
///
/// When using indirect cases for compound statements it is best to place more simple operations
/// towards the outside and nest more complicated operations inside. When building a NSCompoundPredicate from
/// a filter the outer most filters will be placed first in the array of NSPredicates. Similarly, when bulding a closure
/// the structure
/// is maintained so that the outer most is evaluated first.
public struct EquatableFilter<T: Equatable>: Equatable, CompoundFilterable, OptionalFilterable {
    public let equalTo: T

    @inlinable
    public static func equalTo(_ value: T) -> Self {
        self.init(equalTo: value)
    }

    // swiftlint:disable unneeded_synthesized_initializer
    @usableFromInline
    init(equalTo: T) {
        self.equalTo = equalTo
    }

    // swiftlint:enable unneeded_synthesized_initializer
}

extension EquatableFilter: Hashable where T: Hashable {}

extension EquatableFilter: Sendable where T: Sendable {}
