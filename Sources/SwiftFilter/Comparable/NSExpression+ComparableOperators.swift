//
//  NSExpression+ComparableOperators.swift
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
    /// - Parameter type: See NSComparisonPredicate.
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    internal func comparisonPredicate(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        type: NSComparisonPredicate.Operator,
        options: NSComparisonPredicate.Options = []
    ) -> NSComparisonPredicate {
        return NSComparisonPredicate(
            leftExpression: self,
            rightExpression: rhs,
            modifier: modifier,
            type: type,
            options: options
        )
    }

    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    public func lessThan(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        return comparisonPredicate(rhs, modifier: modifier, type: .lessThan, options: options)
    }

    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    public func lessThanOrEqualTo(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        return comparisonPredicate(rhs, modifier: modifier, type: .lessThanOrEqualTo, options: options)
    }

    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    public func greaterThan(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        return comparisonPredicate(rhs, modifier: modifier, type: .greaterThan, options: options)
    }

    /// Convenience method for creating a NSPredicate on an NSExpression
    ///
    /// - Parameter rhs: Right hand side NSExpression. Corresponds to `self` in a NSComparisonPredicate.
    /// - Parameter modifer: See NSComparisonPredicate. Default: `.direct`
    /// - Parameter options: See NSComparisonPredicate. Default: `[]`
    public func greaterThanOrEqualTo(
        _ rhs: NSExpression,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        return comparisonPredicate(rhs, modifier: modifier, type: .greaterThanOrEqualTo, options: options)
    }
}
