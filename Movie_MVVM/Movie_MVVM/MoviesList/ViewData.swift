// ViewData.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Состояния вью
enum ViewData: Equatable {
    case initial
    case loading
    case success([Movie])
    case failure(Error)

    static func == (lhs: ViewData, rhs: ViewData) -> Bool {
        true
    }
}
