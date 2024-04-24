// OptionalFilterable+CompoundFilterable.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

////
////  File.swift
////
////
////  Created by andrew on 4/23/24.
////
//
// extension OptionalFilterable where Self: CompoundFilterable {
//    @inlinable
//    public static func and(_ lhs: OptionalFilter<Self>, _ rhs: OptionalFilter<Self>) ->
//    CompoundFilter<OptionalFilter<Self>> {
//        .and(lhs, rhs)
//    }
//
//    @inlinable
//    public static func andMulti(_ filters: [OptionalFilter<Self>]) -> CompoundFilter<OptionalFilter<Self>> {
//        .andMulti(filters)
//    }
//
//    @inlinable
//    public static func not(_ filter: OptionalFilter<Self>) -> CompoundFilter<OptionalFilter<Self>> {
//        .not(filter)
//    }
//
//    @inlinable
//    public static func or(_ lhs: OptionalFilter<Self>, _ rhs: OptionalFilter<Self>) ->
//    CompoundFilter<OptionalFilter<Self>> {
//        .or(lhs, rhs)
//    }
//
//    @inlinable
//    public static func orMulti(_ filters: [OptionalFilter<Self>]) -> CompoundFilter<OptionalFilter<Self>> {
//        .orMulti(filters)
//    }
// }
