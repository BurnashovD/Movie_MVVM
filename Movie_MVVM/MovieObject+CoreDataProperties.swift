// MovieObject+CoreDataProperties.swift
// Copyright © DB. All rights reserved.

import CoreData
import Foundation

/// Расширение с свойствами фильма кордаты
public extension MovieObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieObject> {
        NSFetchRequest<MovieObject>(entityName: "MovieObject")
    }

    /// Изображение фильма
    @NSManaged var backdropPath: String?
    /// Фильтер
    @NSManaged var filter: String?
    /// Идентификатор
    @NSManaged var id: Int64
    /// Описание
    @NSManaged var overview: String?
    /// Дополнительное изображение
    @NSManaged var posterPath: String?
    /// Название
    @NSManaged var title: String?
    /// Оценка
    @NSManaged var voteAvarage: Double
    /// Актеры
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
