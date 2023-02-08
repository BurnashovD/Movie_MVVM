// ViewData.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Состояния вью
enum ViewData {
    case initial
    case loading
    case success([Movie])
    case failure(Error)
}
