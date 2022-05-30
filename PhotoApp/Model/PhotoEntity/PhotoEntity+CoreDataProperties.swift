//
//  PhotoEntity+CoreDataProperties.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 25/05/2022.
//
//

import Foundation
import CoreData

extension PhotoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var identifier: Double
    @NSManaged public var albumId: Double
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var place: Double

    func update(with model: PhotoModel, place: Int) {
        self.identifier = Double(model.id)
        self.albumId = Double(model.albumId)
        self.title = model.title
        self.thumbnailUrl = model.thumbnailUrl
        self.url = model.url
        self.place = Double(place)
    }
}

extension PhotoEntity : Identifiable {
}
