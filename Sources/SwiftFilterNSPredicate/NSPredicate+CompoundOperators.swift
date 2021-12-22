// NSPredicate+CompoundOperators.swift
// SwiftFilter
//
//
// MIT License
//
// Copyright © 2021 Andrew Roan

import Foundation

extension NSPredicate {
    /// Convenience method for creating a NSCompoundPredicate on a NSPredicate.
    ///
    /// - Parameter predicate: NSPredicate to be "and'd" with self.
    public func and(_ predicate: NSPredicate) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }

    /// Convenience method for creating a NSCompoundPredicate from an array of NSPredicates.
    ///
    /// - Parameter predicates: Array of NSPredicates to be "and'd".
    public static func and(_ predicates: [NSPredicate]) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    /// Convenience method for creating a NSCompoundPredicate on a NSPredicate.
    ///
    /// - Parameter predicate: NSPredicate to be inverted.
    public static func not(_ predicate: NSPredicate) -> NSPredicate {
        NSCompoundPredicate(notPredicateWithSubpredicate: predicate)
    }

    /// Convenience method for creating a NSCompoundPredicate to invert `self`.
    public func not() -> NSPredicate {
        NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }

    /// Convenience method for creating a NSCompoundPredicate on a NSPredicate.
    ///
    /// - Parameter predicate: NSPredicate to be "or'd" with self.
    public func or(_ predicate: NSPredicate) -> NSPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }

    /// Convenience method for creating a NSCompoundPredicate on a NSPredicate.
    ///
    /// - Parameter predicates: Array of NSPredicates to be "or'd".
    public static func or(_ predicates: [NSPredicate]) -> NSPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
}
