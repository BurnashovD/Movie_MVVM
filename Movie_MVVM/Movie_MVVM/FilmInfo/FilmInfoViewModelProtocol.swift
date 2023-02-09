// FilmInfoViewModelProtocol.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол вью модели экрана с информацией о выбранном фильме
protocol FilmInfoViewModelProtocol {
    var updateHandler: (() -> Void)? { get set }
    var errorHandler: ((Error) -> Void)? { get set }
    var trailers: [Trailer] { get set }
    var actors: [Actor] { get set }
    var movie: Movie? { get set }
    func fetchActors()
    func fetchTrailers()
    func viewDidDisapeardAction()
    func openTrailerWebViewAction(_ trailer: Trailer)
    func loadActors()
}
