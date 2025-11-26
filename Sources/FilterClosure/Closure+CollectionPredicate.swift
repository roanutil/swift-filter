// Closure+CollectionPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright Andrew Roan

import Filter
import Foundation

extension Closure: CollectionPredicate where Value: Collection, Value: Equatable, Value.Element: Equatable {
    /// Creates a closure `(Self) -> Bool` from a CollectionFilter
    ///
    /// For platforms before iOS 16/macOS 13/etc, ``CollectionFilter/isIn`` is implemented by checking if each element
    /// is contained.
    ///
    /// - Parameter filter: An instance of CollectionFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(from filter: CollectionFilter<Value>,
                             on keyPath: KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    {
        switch filter {
        case let .isIn(values):
            if #available(iOS 16, macOS 13, watchOS 9, tvOS 16, macCatalyst 16, *) {
                return { values.contains($0[keyPath: keyPath]) }
            } else {
                return { $0[keyPath: keyPath].allSatisfy { values.contains($0) } }
            }
        case let .sequence(sequenceFilter):
            return Closure.build(from: sequenceFilter, on: keyPath)
        case let .or(lhs, rhs):
            let lhsClosure = Self.build(from: lhs, on: keyPath)
            let rhsClosure = Self.build(from: rhs, on: keyPath)
            return { lhsClosure($0) || rhsClosure($0) }
        case let .orMulti(filters):
            let predicates = filters.map { Self.build(from: $0, on: keyPath) }
            return { value in
                predicates.contains { $0(value) }
            }
        case let .and(lhs, rhs):
            let lhsClosure = Self.build(from: lhs, on: keyPath)
            let rhsClosure = Self.build(from: rhs, on: keyPath)
            return { lhsClosure($0) && rhsClosure($0) }
        case let .andMulti(filters):
            let predicates = filters.map { Self.build(from: $0, on: keyPath) }
            return { value in predicates.allSatisfy { $0(value) }}
        case let .not(inverted):
            let invertedClosure = Self.build(from: inverted, on: keyPath)
            return { !invertedClosure($0) }
        }
    }
}
