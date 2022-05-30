//
//  PhotoEntityService.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 22/05/2022.
//

import Foundation
import CoreData

class PhotoEntityService{

    private let persistentContainer: NSPersistentContainer
    private let container: NSPersistentContainer
    private let containerName: String = "Model"
    private let entityName: String = "PhotoEntity"
    private let backgroundContext: NSManagedObjectContext!
    @Published var savedEntities: [PhotoEntity] = []

    lazy var mainContext: NSManagedObjectContext = {
        return container.viewContext
    }()

    init() {
        persistentContainer = CoreDataStack.shared.persistentContainer
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        backgroundContext = container.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    fileprivate func save(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error: \(error)\nCould not save Core Data context.")
            }
            context.reset()
        }
    }

    func add(photos: [PhotoModel]) {
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil

        taskContext.performAndWait {
            for (index, photoModel) in photos.enumerated() {
                guard let photo = NSEntityDescription.insertNewObject(forEntityName: "PhotoEntity", into: taskContext) as? PhotoEntity else {
                    print("Error: Failed to create a new PhotoEntity object!")
                    return
                }
                photo.update(with: photoModel, place: index)
            }
            save(taskContext)
        }
    }

    func fetchAll() async -> [PhotoModel] {
        var photos = [PhotoModel]()
        let context = persistentContainer.viewContext
        do {
            let fetch = PhotoEntity.fetchRequest()
            let placeSort = NSSortDescriptor(key:"place", ascending:true)
            fetch.sortDescriptors = [placeSort]
            photos = try context.fetch(fetch).map{
                PhotoModel(entity: $0)
            }
        } catch {

        }
        return photos
    }

    func updateAll(_ photos: [PhotoModel]) {
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        do {
            try taskContext.performAndWait {
                let fetch = PhotoEntity.fetchRequest()
                let placeSort = NSSortDescriptor(key:"place", ascending:true)
                fetch.sortDescriptors = [placeSort]

                _ = try taskContext.fetch(fetch).map { objectToUpdate in
                    if let index = photos.firstIndex(where: { item in
                        item.id == Int(objectToUpdate.identifier)
                    }) {
                        let place = Double(index)
                        objectToUpdate.place = place
                    } else {
                        taskContext.delete(objectToUpdate)
                    }
                }
                save(taskContext)
            }
        } catch {

        }
    }
}

class CoreDataStack {

    private init() {}
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")

        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()
}
