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
public enum ComparableFilter<T: Comparable>: Equatable, CompoundFilterable {
    case lessThan(T)
    case lessThanOrEqualTo(T)
    case greaterThan(T)
    case greaterThanOrEqualTo(T)
    case equatable(EquatableFilter<T>)
}

extension ComparableFilter: Hashable where T: Hashable {}

extension ComparableFilter: Sendable where T: Sendable {}
