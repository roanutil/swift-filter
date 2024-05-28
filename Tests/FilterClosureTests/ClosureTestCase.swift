// ClosureTestCase.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

import FilterClosure

protocol ClosureTestCase {
    func predicateType<R, V>() -> Closure<R, V>.Type
}

extension ClosureTestCase {
    func predicateType<R, V>() -> Closure<R, V>.Type {
        Closure.self
    }
}
