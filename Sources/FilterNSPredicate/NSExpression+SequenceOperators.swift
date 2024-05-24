// NSExpression+SequenceOperators.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import Foundation

extension NSExpression {
    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    @inlinable
    public func contains(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        comparisonPredicate(rhs, modifier: modifier, type: .contains, options: options)
    }
}
