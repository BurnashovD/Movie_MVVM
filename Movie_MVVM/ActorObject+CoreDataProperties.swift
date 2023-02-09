// ActorObject+CoreDataProperties.swift
// Copyright © DB. All rights reserved.

import CoreData
import Foundation

public extension ActorObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ActorObject> {
        NSFetchRequest<ActorObject>(entityName: "ActorObject")
    }

    @NSManaged var id: Int64
    @NSManaged var originalName: String?
    @NSManaged var posterPath: String?
    @NSManaged var order: Int64
    @NSManaged var movie: MovieObject?
}

extension ActorObject: Identifiable {}
