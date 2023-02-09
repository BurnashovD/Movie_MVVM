// ActorObject+CoreDataProperties.swift
// Copyright © DB. All rights reserved.

import CoreData
import Foundation

/// Расширение с свойствами актера кордаты
public extension ActorObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ActorObject> {
        NSFetchRequest<ActorObject>(entityName: "ActorObject")
    }

    /// Идентификатор
    @NSManaged var id: Int64
    /// Имя актера
    @NSManaged var originalName: String?
    /// Фото актера
    @NSManaged var posterPath: String?
    /// Фильтр сортировки
    @NSManaged var order: Int64
    /// Фильм
    @NSManaged var movie: MovieObject?
}

extension ActorObject: Identifiable {}
