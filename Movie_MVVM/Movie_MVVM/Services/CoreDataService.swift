// CoreDataService.swift
// Copyright © DB. All rights reserved.

import CoreData
import UIKit

struct CoreDataService: CoreDataProtocol {
    func saveMovies(_ movies: [Movie]) {
        guard
            let context = createContext(),
            let entity = NSEntityDescription.entity(forEntityName: "MovieObject", in: context)
        else { return }
        do {
            try movies.forEach { movie in
                deleteObjects(Int64(movie.id))
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
            let entity = NSEntityDescription.entity(forEntityName: "ActorObject", in: context)
        else { return }
        let fetch = MovieObject.fetchRequest()
        let selectedMovie = try? context.fetch(fetch).first(where: { $0.id == id })
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ActorObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try? context.execute(deleteRequest)
            try? actors.forEach { actor in
                let actorObject = ActorObject(entity: entity, insertInto: context)
                actorObject.id = Int64(actor.id)
                actorObject.originalName = actor.originalName
                actorObject.posterPath = actor.profilePath

//                selectedMovie?.actors?.append(actorObject)
                try? context.save()
            }
        }
    }

    func getActors(_ id: Int) {
        guard
            let delegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let context = delegate.persistentContainer.viewContext
//        let context = createContext()
        let fetch = MovieObject.fetchRequest()
        let selectedMovie = try? context.fetch(fetch).first(where: { $0.id == id })
//        print("documents\(selectedMovie?.actors?.count)")
    }

    func getMovies(parameter: NetworkService.ParameterType) -> [Movie]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let fetch = MovieObject.fetchRequest()
        let context = createContext()
        var movies: [Movie] = []
        var moviesObjects: [MovieObject]? = []
        do {
//            try context?.execute(deleteRequest)
            if parameter == .popular {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == "popular" }
            } else if parameter == .topRated {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == "topRated" }
            } else if parameter == .upcoming {
                moviesObjects = try context?.fetch(fetch).filter { $0.filter == "upcoming" }
            }
            moviesObjects?.forEach { obj in
                guard let convertedMovie = convertMovieObject(obj) else { return }
                movies.append(convertedMovie)
            }
            return movies
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func deleteObjects(_ id: Int64) {
        let fetch = MovieObject.fetchRequest()
        let context = createContext()
        let result = try? context?.fetch(fetch).filter { $0.id == id }
        result?.forEach { object in
            context?.delete(object)
        }
    }

    private func convertActorObject(_ actor: ActorObject) -> Actor? {
        let actor = Actor(id: Int(actor.id), originalName: actor.originalName ?? "", profilePath: actor.posterPath)
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
        context.mergePolicy = NSOverwriteMergePolicy
        return context
    }
}
