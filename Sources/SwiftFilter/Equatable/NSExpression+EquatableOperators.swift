//
//  NSExpression+EquatableOperators.swift
//  
//
//  MIT License
//
//  Copyright (c) 2020 Andrew Roan
//

import Foundation

extension NSExpression {
    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    public func equalTo(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        return comparisonPredicate(rhs, modifier: modifier, type: .equalTo, options: options)
    }
}
