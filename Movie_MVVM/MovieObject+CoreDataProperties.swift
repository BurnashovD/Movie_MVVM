// MovieObject+CoreDataProperties.swift
// Copyright © DB. All rights reserved.

import CoreData
import Foundation

public extension MovieObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieObject> {
        NSFetchRequest<MovieObject>(entityName: "MovieObject")
    }

    @NSManaged var backdropPath: String?
    @NSManaged var filter: String?
    @NSManaged var id: Int64
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var title: String?
    @NSManaged var voteAvarage: Double
    @NSManaged var actors: Set<ActorObject>?
}

// MARK: Generated accessors for actors

public extension MovieObject {
    @objc(addActorsObject:)
    @NSManaged func addToActors(_ value: ActorObject)

    @objc(removeActorsObject:)
    @NSManaged func removeFromActors(_ value: ActorObject)

    @objc(addActors:)
    @NSManaged func addToActors(_ values: Set<ActorObject>)

    @objc(removeActors:)
    @NSManaged func removeFromActors(_ values: Set<ActorObject>)
}

extension MovieObject: Identifiable {}
