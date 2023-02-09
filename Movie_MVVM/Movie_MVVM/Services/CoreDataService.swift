// CoreDataService.swift
// Copyright © DB. All rights reserved.

import CoreData
import UIKit

/// Сервис сохранения данных в базу данных
struct CoreDataService: CoreDataServiceProtocol {
    // MARK: - Public methods

    func saveMovies(_ movies: [Movie]) {
        guard
            let context = createContext(),
            let entity = NSEntityDescription.entity(forEntityName: Constants.movieEntityName, in: context)
        else { return }
        do {
            try movies.forEach { movie in
                deleteMovieObjects(Int64(movie.id))
                let object = MovieObject(entity: entity, insertInto: context)
                object.id = Int64(movie.id)
                object.posterPath = movie.posterPath
                object.backdropPath = movie.backdropPath
                object.overview = movie.overview
                object.title = movie.title
                object.voteAvarage = movie.voteAverage
                object.filter = movie.filter

                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveActors(_ actors: [Actor], id: Int) {
        guard
            let context = createContext(),
            let entity = NSEntityDescription.entity(forEntityName: Constants.actorEntityName, in: context)
        else { return }
        let fetch = MovieObject.fetchRequest()
        let selectedMovie = try? context.fetch(fetch).first(where: { $0.id == id })
        var actorsSet = Set<ActorObject>()
        do {
            actors.forEach { actor in
                deleteActorObjects(actor.originalName)
                let actorObject = ActorObject(entity: entity, insertInto: context)
                actorObject.id = Int64(actor.id)
                actorObject.originalName = actor.originalName
                actorObject.posterPath = actor.profilePath
                actorObject.order = Int64(actor.order)
                actorsSet.insert(actorObject)
            }
            selectedMovie?.actors = actorsSet
            try? context.save()
        }
    }

    func getActors(_ id: Int) -> [Actor]? {
        guard let context = createContext() else { return nil }
        let fetch = MovieObject.fetchRequest()
        let selectedMovie = try? context.fetch(fetch).first(where: { $0.id == id })
        var actors: [Actor] = []
        do {
            selectedMovie?.actors?.forEach { object in
                guard let actor = convertActorObject(object) else { return }
                actors.append(actor)
            }
            actors.sort(by: { $0.order < $1.order })
            return actors
        }
    }

    func getMovies(parameter: NetworkService.ParameterType) -> [Movie]? {
        let fetch = MovieObject.fetchRequest()
        let context = createContext()
        var movies: [Movie] = []
        var moviesObjects: [MovieObject]? = []
        do {
            if parameter == .popular {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == Constants.popularFilterName }
            } else if parameter == .topRated {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == Constants.topRatedFilterName }
            } else if parameter == .upcoming {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == Constants.upcomingFilterName }
            }
            moviesObjects?.forEach { object in
                guard let convertedMovie = convertMovieObject(object) else { return }
                movies.append(convertedMovie)
            }
            return movies
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    // MARK: - Private methods

    private func deleteMovieObjects(_ id: Int64) {
        let fetch = MovieObject.fetchRequest()
        let context = createContext()
        let result = try? context?.fetch(fetch).filter { $0.id == id }
        result?.forEach { object in
            context?.delete(object)
        }
    }

    private func deleteActorObjects(_ name: String) {
        let fetch = ActorObject.fetchRequest()
        let context = createContext()
        let result = try? context?.fetch(fetch).filter { $0.originalName == name }
        result?.forEach { object in
            context?.delete(object)
        }
    }

    private func convertActorObject(_ actor: ActorObject) -> Actor? {
        let actor = Actor(
            id: Int(actor.id),
            originalName: actor.originalName ?? "",
            profilePath: actor.posterPath,
            order: Int(actor.order)
        )
        return actor
    }

    private func convertMovieObject(_ movie: MovieObject) -> Movie? {
        guard let movieObject = Movie(
            backdropPath: movie.backdropPath ?? "",
            id: Int(movie.id),
            overview: movie.overview ?? "",
            posterPath: movie.posterPath ?? "",
            title: movie.title ?? "",
            voteAverage: movie.voteAvarage,
            filmImage: UIImage(),
            currentFilmId: "",
            filter: movie.filter ?? ""
        ) else { return nil }
        return movieObject
    }

    private func createContext() -> NSManagedObjectContext? {
        guard
            let delegate = UIApplication.shared.delegate as? AppDelegate
        else { return nil }
        let context = delegate.persistentContainer.viewContext
        return context
    }
}

/// Константы
private extension CoreDataService {
    enum Constants {
        static let movieEntityName = "MovieObject"
        static let actorEntityName = "ActorObject"
        static let popularFilterName = "popular"
        static let upcomingFilterName = "upcoming"
        static let topRatedFilterName = "topRated"
    }
}
