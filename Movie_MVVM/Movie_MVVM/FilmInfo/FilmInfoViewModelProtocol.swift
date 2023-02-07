// FilmInfoViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели экрана с информацией о выбранном фильме
protocol FilmInfoViewModelProtocol {
    var updateActorsHandler: (([Actor]) -> Void)? { get set }
    var updateTrailersHandler: (([Trailer]) -> Void)? { get set }
    var movie: Movie? { get set }
    func fetchActors()
    func fetchTrailers()
    func viewDidDisapeardAction()
    func openTrailerWebViewAction(_ trailer: Trailer)
}
