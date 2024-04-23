// NSPredicate+AnyOptionalPredicate.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

//// NSPredicate+OptionalAnyEquatablePredicate.swift
//// Filter
////
////
//// MIT License
////
//// Copyright © 2024 Andrew Roan
//
// import Filter
// import Foundation
//
// extension NSPredicate: AnyOptionalPredicate {
//    /// Creates a NSPredicate from a EquatableFilter.Optional
//    ///
//    /// - Parameter filter: An instance of EquatableFilter.Optional representing the logic of the resulting
//    /NSPredicate.
//    /// - Parameter keyPath: A keypath instructing what value to use for evaluating the predicate.
//    @inlinable
//    public static func build<Root, Value, Wrapped>(
//        from filter: OptionalFilter<Wrapped>,
//        on keyPath: KeyPath<Root, Value?>,
//        buildWrapped: (_ from: Wrapped, _ on: KeyPath<Root, Value?>) -> NSPredicate
//    ) -> NSPredicate where Value: Equatable {
//        switch filter {
//        case let .orNil(subFilter):
//            return buildWrapped(subFilter, keyPath)
//        case let .notNil(subFilter):
//            if let subFilter {
//                return buildWrapped(subFilter, keyPath)
//                    .and(NSExpression(forKeyPath: keyPath).comparisonPredicate(NSExpression(forConstantValue: nil), type: .notEqualTo))
//            }
//            return NSExpression(forKeyPath: keyPath).comparisonPredicate(NSExpression(forConstantValue: nil), type:
//            .notEqualTo)
//        case .isNil:
//            return NSExpression(forKeyPath: keyPath).equalTo(NSExpression(forConstantValue: nil))
//        }
//    }
// }
