// Closure+SequencePredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Filter
import Foundation

extension Closure: SequencePredicate where Value: Sequence, Value: Equatable, Value.Element: Equatable {
    /// Creates a closure `(Self) -> Bool` from a SequenceFilter
    ///
    /// ``SequenceFilter\endsWith`` is implemented by reversing the sequence and using `Sequence.starts(with:)`.
    ///
    /// - Parameter filter: An instance of SequenceFilter representing the logic of the resulting NSPredicate.
    @inlinable
    public static func build(from filter: SequenceFilter<Value>,
                             on keyPath: KeyPath<Root, Value>) -> (@Sendable (Root) -> Bool)
    {
        { $0[keyPath: keyPath].contains(filter.contains) }
    }
}
