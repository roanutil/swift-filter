// CompoundFilter.swift
// Filter
//
//
// MIT License
//
// Copyright © 2024 Andrew Roan

@frozen
public enum CompoundFilter<T> {
    case or(T, T)
    case orMulti([T])
    case and(T, T)
    case andMulti([T])
    case not(T)
}
